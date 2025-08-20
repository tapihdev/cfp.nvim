local M = {}

M.setup = function()
  local config = require("cfp.config")
  local cfp = require("cfp")

  local opts = config.get()
  local keymaps = opts.keymaps

  if keymaps.copy_path then
    vim.keymap.set("n", keymaps.copy_path, cfp.copy_path, {
      desc = "Copy file path"
    })
  end

  if keymaps.copy_path_line then
    vim.keymap.set("n", keymaps.copy_path_line, cfp.copy_path_line, {
      desc = "Copy file path with line number"
    })
  end

  if keymaps.copy_path_url then
    vim.keymap.set("n", keymaps.copy_path_url, cfp.copy_path_url, {
      desc = "Copy file path as GitHub URL"
    })
  end

  if keymaps.copy_path_hash then
    vim.keymap.set("n", keymaps.copy_path_hash, cfp.copy_path_hash, {
      desc = "Copy file path as GitHub URL with commit hash"
    })
  end

  if keymaps.copy_path_with_hash then
    vim.keymap.set("n", keymaps.copy_path_with_hash, cfp.copy_path_with_hash, {
      desc = "Copy file path"
    })
  end
end

return M