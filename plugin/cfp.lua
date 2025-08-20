-- Create user commands for cfp.nvim
vim.api.nvim_create_user_command("CopyPath", function() require("cfp").copy_path() end, {
  desc = "Copy current file relative path to clipboard",
})

vim.api.nvim_create_user_command("CopyPathLine", function() require("cfp").copy_path_line() end, {
  desc = "Copy current file relative path with line number to clipboard",
})

vim.api.nvim_create_user_command("CopyBranchURL", function() require("cfp").copy_path_url() end, {
  desc = "Copy current file relative path as GitHub URL with branch name to clipboard",
})

vim.api.nvim_create_user_command("CopyBranchURLLine", function() require("cfp").copy_path_url() end, {
  desc = "Copy current file relative path with line number as GitHub URL with branch name to clipboard",
})

vim.api.nvim_create_user_command("CopyHashURL", function() require("cfp").copy_path_hash() end, {
  desc = "Copy current file relative path as GitHub URL with commit hash to clipboard",
})

vim.api.nvim_create_user_command("CopyHashURLLine", function() require("cfp").copy_path_with_hash() end, {
  desc = "Copy current file relative path with line number as GitHub URL with commit hash to clipboard",
})

