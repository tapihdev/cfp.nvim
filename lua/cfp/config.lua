local M = {}

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

local config = {}

function M.setup(opts)
  config = vim.tbl_deep_extend("force", defaults, opts or {})
end

function M.get()
  return config
end

return M
