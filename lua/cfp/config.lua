local M = {}

local defaults = {
  keymaps = {
    copy_path = "<leader>cp",
    copy_path_line = "<leader>cl",
    copy_path_url = "<leader>cu",
  },
}

local config = {}

function M.setup(opts)
  config = vim.tbl_deep_extend("force", defaults, opts or {})
end

function M.get()
  return config
end

return M