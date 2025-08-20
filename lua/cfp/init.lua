local M = {}

-- Get the current buffer's file path relative to the current working directory
local function get_relative_path()
  local buf_path = vim.api.nvim_buf_get_name(0)
  if buf_path == "" then return nil end

  local relative_path = vim.fn.fnamemodify(buf_path, ":.")

  return relative_path
end

-- Copy text to clipboard
local function copy_to_clipboard(text)
  vim.fn.setreg("+", text)
  vim.notify("Copied to clipboard: " .. text, vim.log.levels.INFO)
end

-- Create GitHub URL for file
local function create_github_url(path, ref_type, include_line)
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

  -- Build URL
  local url = github_url .. "/blob/" .. ref .. "/" .. path
  if include_line then
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    url = url .. "#L" .. line_num
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
function M.copy_path_line()
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local path_with_line = path .. ":" .. line_num

  copy_to_clipboard(path_with_line)
end

-- Copy current file relative path as GitHub URL with branch name to clipboard
function M.copy_branch_url()
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  local url = create_github_url(path, "branch", false)
  if url then
    copy_to_clipboard(url)
  end
end

-- Copy current file relative path with line number as GitHub URL with branch name to clipboard
function M.copy_branch_url_line()
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  local url = create_github_url(path, "branch", true)
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

  local url = create_github_url(path, "hash", false)
  if url then
    copy_to_clipboard(url)
  end
end

-- Copy current file relative path with line number as GitHub URL with commit hash to clipboard
function M.copy_hash_url_line()
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end

  local url = create_github_url(path, "hash", true)
  if url then
    copy_to_clipboard(url)
  end
end

return M

