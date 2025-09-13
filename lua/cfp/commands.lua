local M = {}

-- Get the current buffer's file path relative to the Git root (if available),
-- otherwise relative to the current working directory.
local function get_relative_path()
  local buf_path = vim.api.nvim_buf_get_name(0)
  if buf_path == "" then return nil end

  -- Normalize to absolute and realpath for robust prefix checks
  local abs_buf = vim.fn.fnamemodify(buf_path, ":p")
  local real_buf = (vim.loop or vim.uv).fs_realpath(abs_buf) or abs_buf

  -- Try Git root first
  local toplevel = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
  if vim.v.shell_error == 0 and toplevel ~= "" then
    local abs_root = vim.fn.fnamemodify(toplevel, ":p")
    local real_root = (vim.loop or vim.uv).fs_realpath(abs_root) or abs_root
    if real_buf:sub(1, #real_root) == real_root then
      local rel = real_buf:sub(#real_root + 2) -- skip trailing '/'
      -- Normalize separators to forward slashes
      rel = rel:gsub("\\", "/")
      return rel
    end
  end

  -- Fallback: relative to current working directory
  local rel_cwd = vim.fn.fnamemodify(buf_path, ":.")
  rel_cwd = rel_cwd:gsub("\\", "/")
  return rel_cwd
end

-- Copy text to clipboard
local function copy_to_clipboard(text)
  vim.fn.setreg("+", text)
  vim.notify("Copied to clipboard: " .. text, vim.log.levels.INFO)
end

-- Get selected line range when in visual mode
local function get_selected_line_range()
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' or mode == '\022' then -- characterwise, linewise, blockwise
    local s = vim.api.nvim_buf_get_mark(0, '<')[1]
    local e = vim.api.nvim_buf_get_mark(0, '>')[1]
    if s > e then s, e = e, s end
    return s, e
  end
  return nil, nil
end

-- Create GitHub URL for file
local function create_github_url(path, ref_type, line_range)
  -- Get Git remote URL
  local git_remote = vim.fn.system("git config --get remote.origin.url"):gsub("\n", "")
  if vim.v.shell_error ~= 0 then
    vim.notify("Not in a Git repository", vim.log.levels.WARN)
    return nil
  end

  -- Convert SSH/HTTPS Git URL to GitHub URL
  local github_url = git_remote
  if github_url:match("^git@github.com:") then
    github_url = github_url:gsub("^git@github.com:", "https://github.com/")
    github_url = github_url:gsub("%.git$", "")
  elseif github_url:match("^https://github.com/") then
    github_url = github_url:gsub("%.git$", "")
  else
    vim.notify("Remote origin is not a GitHub repository", vim.log.levels.WARN)
    return nil
  end

  -- Get reference (branch or commit hash)
  local ref
  if ref_type == "branch" then
    ref = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to get current branch", vim.log.levels.WARN)
      return nil
    end
  elseif ref_type == "hash" then
    ref = vim.fn.system("git rev-parse HEAD"):gsub("\n", "")
    if vim.v.shell_error ~= 0 then
      vim.notify("Failed to get current commit hash", vim.log.levels.WARN)
      return nil
    end
  end

  -- Ensure path uses forward slashes and is not absolute
  local rel_path = path:gsub("^/+", ""):gsub("\\", "/")

  -- Build URL
  local url = github_url .. "/blob/" .. ref .. "/" .. rel_path
  if line_range then
    local s = line_range.start
    local e = line_range.finish
    if s and e and e > s then
      url = url .. "#L" .. s .. "-L" .. e
    elseif s then
      url = url .. "#L" .. s
    end
  end

  return url
end

-- Copy current file relative path to clipboard
function M.copy_path()
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  copy_to_clipboard(path)
end

-- Copy current file relative path with line number to clipboard
function M.copy_path_line(opts)
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  local s, e = get_selected_line_range()
  if opts and opts.range and opts.range > 0 then
    s = opts.line1
    e = opts.line2
  end
  local path_with_line
  if s then
    if e and e > s then
      path_with_line = path .. ":" .. s .. "-" .. e
    else
      path_with_line = path .. ":" .. s
    end
  else
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    path_with_line = path .. ":" .. line_num
  end

  copy_to_clipboard(path_with_line)
end

-- Copy current file relative path as GitHub URL with branch name to clipboard
function M.copy_branch_url()
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  local url = create_github_url(path, "branch", nil)
  if url then
    copy_to_clipboard(url)
  end
end

-- Copy current file relative path with line number as GitHub URL with branch name to clipboard
function M.copy_branch_url_line(opts)
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  local s, e = get_selected_line_range()
  if opts and opts.range and opts.range > 0 then
    s = opts.line1
    e = opts.line2
  end
  local range
  if s then range = { start = s, finish = e } else
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    range = { start = line_num }
  end

  local url = create_github_url(path, "branch", range)
  if url then
    copy_to_clipboard(url)
  end
end

-- Copy current file relative path as GitHub URL with commit hash to clipboard
function M.copy_hash_url()
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  local url = create_github_url(path, "hash", nil)
  if url then
    copy_to_clipboard(url)
  end
end

-- Copy current file relative path with line number as GitHub URL with commit hash to clipboard
function M.copy_hash_url_line(opts)
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  local s, e = get_selected_line_range()
  if opts and opts.range and opts.range > 0 then
    s = opts.line1
    e = opts.line2
  end
  local range
  if s then range = { start = s, finish = e } else
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    range = { start = line_num }
  end

  local url = create_github_url(path, "hash", range)
  if url then
    copy_to_clipboard(url)
  end
end

return M
