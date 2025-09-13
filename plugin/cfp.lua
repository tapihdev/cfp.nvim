-- Create user commands for cfp.nvim
local commands = require("cfp.commands")

vim.api.nvim_create_user_command("CopyPath", function() commands.copy_path() end, {
  desc = "Copy current file relative path to clipboard",
})

vim.api.nvim_create_user_command("CopyPathLine", function(opts) commands.copy_path_line(opts) end, {
  desc = "Copy current file relative path with line number to clipboard",
  range = true,
})

vim.api.nvim_create_user_command("CopyBranchURL", function() commands.copy_branch_url() end, {
  desc = "Copy current file relative path as GitHub URL with branch name to clipboard",
})

vim.api.nvim_create_user_command("CopyBranchURLLine", function(opts) commands.copy_branch_url_line(opts) end, {
  desc = "Copy current file relative path with line number as GitHub URL with branch name to clipboard",
  range = true,
})

vim.api.nvim_create_user_command("CopyHashURL", function() commands.copy_hash_url() end, {
  desc = "Copy current file relative path as GitHub URL with commit hash to clipboard",
})

vim.api.nvim_create_user_command("CopyHashURLLine", function(opts) commands.copy_hash_url_line(opts) end, {
  desc = "Copy current file relative path with line number as GitHub URL with commit hash to clipboard",
  range = true,
})
