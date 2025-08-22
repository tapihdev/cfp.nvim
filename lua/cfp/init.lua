local M = {}

function M.setup(opts)
  local keymaps = require("cfp.keymaps")
  local commands = require("cfp.commmands")

  local defaults = {
    keymaps = {
      copy_path = "<leader>cp",
      copy_path_line = "<leader>cP",
      copy_branch_url = "<leader>cb",
      copy_branch_url_line = "<leader>cB",
      copy_hash_url = "<leader>ch",
      copy_hash_url_line = "<leader>cH",
    },
  }

  local config = vim.tbl_deep_extend("force", defaults, opts or {})

  keymaps.set_keymaps(config.keymaps, commands)
end

return M

