local M = {}

function M.set_keymaps(keymaps, commands)
  if keymaps.copy_path then
    vim.keymap.set("n", keymaps.copy_path, commands.copy_path, {
      desc = "Copy current file relative path to clipboard"
    })
    vim.keymap.set("x", keymaps.copy_path, commands.copy_path, {
      desc = "Copy current file relative path to clipboard"
    })
  end

  if keymaps.copy_path_line then
    vim.keymap.set("n", keymaps.copy_path_line, commands.copy_path_line, {
      desc = "Copy current file relative path with line number to clipboard"
    })
    vim.keymap.set("x", keymaps.copy_path_line, ":'<,'>CopyPathLine<CR>", {
      desc = "Copy current file relative path with line number or range to clipboard",
      silent = true
    })
  end

  if keymaps.copy_branch_url then
    vim.keymap.set("n", keymaps.copy_branch_url, commands.copy_branch_url, {
      desc = "Copy current file relative path as GitHub URL with branch name to clipboard"
    })
    vim.keymap.set("x", keymaps.copy_branch_url, commands.copy_branch_url, {
      desc = "Copy current file relative path as GitHub URL with branch name to clipboard"
    })
  end

  if keymaps.copy_branch_url_line then
    vim.keymap.set("n", keymaps.copy_branch_url_line, commands.copy_branch_url_line, {
      desc = "Copy current file relative path with line number as GitHub URL with branch name to clipboard",
    })
    vim.keymap.set("x", keymaps.copy_branch_url_line, ":'<,'>CopyBranchURLLine<CR>", {
      desc = "Copy current file relative path with line range as GitHub URL with branch name to clipboard",
      silent = true
    })
  end

  if keymaps.copy_hash_url then
    vim.keymap.set("n", keymaps.copy_hash_url, commands.copy_hash_url, {
      desc = "Copy current file relative path as GitHub URL with commit hash to clipboard"
    })
    vim.keymap.set("x", keymaps.copy_hash_url, commands.copy_hash_url, {
      desc = "Copy current file relative path as GitHub URL with commit hash to clipboard"
    })
  end

  if keymaps.copy_hash_url_line then
    vim.keymap.set("n", keymaps.copy_hash_url_line, commands.copy_hash_url_line, {
      desc = "Copy current file relative path with line number as GitHub URL with commit hash to clipboard"
    })
    vim.keymap.set("x", keymaps.copy_hash_url_line, ":'<,'>CopyHashURLLine<CR>", {
      desc = "Copy current file relative path with line range as GitHub URL with commit hash to clipboard",
      silent = true
    })
  end
end

return M
