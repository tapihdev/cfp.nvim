local M = {}

-- Get the current buffer's file path relative to the current working directory
local function get_relative_path()
  local buf_path = vim.api.nvim_buf_get_name(0)
  if buf_path == "" then
    return nil
  end
  
  local cwd = vim.fn.getcwd()
  local relative_path = vim.fn.fnamemodify(buf_path, ":.")
  
  return relative_path
end

-- Copy text to clipboard
local function copy_to_clipboard(text)
  vim.fn.setreg("+", text)
  vim.notify("Copied to clipboard: " .. text, vim.log.levels.INFO)
end

-- Copy relative path
function M.copy_path()
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end
  
  copy_to_clipboard(path)
end

-- Copy relative path with line number
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

-- Copy relative path with line number as GitHub URL
function M.copy_path_url()
  local path = get_relative_path()
  if not path then
    vim.notify("No file path available", vim.log.levels.WARN)
    return
  end
  
  -- Get Git remote URL
  local git_remote = vim.fn.system("git config --get remote.origin.url"):gsub("\n", "")
  if vim.v.shell_error ~= 0 then
    vim.notify("Not in a Git repository", vim.log.levels.WARN)
    return
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
    return
  end
  
  -- Get current branch
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD"):gsub("\n", "")
  if vim.v.shell_error ~= 0 then
    vim.notify("Failed to get current branch", vim.log.levels.WARN)
    return
  end
  
  local line_num = vim.api.nvim_win_get_cursor(0)[1]
  local github_file_url = github_url .. "/blob/" .. branch .. "/" .. path .. "#L" .. line_num
  
  copy_to_clipboard(github_file_url)
end

return M