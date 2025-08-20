local M = {}

M.setup = function()
  local config = require("cfp.config")
  local cfp = require("cfp")

  local opts = config.get()
  local keymaps = opts.keymaps

  if keymaps.copy_path then
    vim.keymap.set("n", keymaps.copy_path, cfp.copy_path, {
      desc = "Copy current file relative path to clipboard"
    })
  end

  if keymaps.copy_path_line then
    vim.keymap.set("n", keymaps.copy_path_line, cfp.copy_path_line, {
      desc = "Copy current file relative path with line number to clipboard"
    })
  end

  if keymaps.copy_branch_url then
    vim.keymap.set("n", keymaps.copy_branch_url, cfp.copy_branch_url, {
      desc = "Copy current file relative path as GitHub URL with branch name to clipboard"
    })
  end

  if keymaps.copy_branch_url_line then
    vim.keymap.set("n", keymaps.copy_branch_url_line, cfp.copy_branch_url_line, {
      desc = "Copy current file relative path with line number as GitHub URL with branch name to clipboard",
    })
  end

  if keymaps.copy_hash_url then
    vim.keymap.set("n", keymaps.copy_hash_url, cfp.copy_hash_url, {
      desc = "Copy current file relative path as GitHub URL with commit hash to clipboard"
    })
  end

  if keymaps.copy_hash_url_line then
    vim.keymap.set("n", keymaps.copy_hash_url_line, cfp.copy_hash_url_line, {
      desc = "Copy current file relative path with line number as GitHub URL with commit hash to clipboard"
    })
  end
end

return M
