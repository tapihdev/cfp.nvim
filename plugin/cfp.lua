-- Create user commands for cfp.nvim
vim.api.nvim_create_user_command("CopyPath", function() require("cfp").copy_path() end, {
  desc = "Copy current file relative path to clipboard",
})

vim.api.nvim_create_user_command("CopyPathLine", function() require("cfp").copy_path_line() end, {
  desc = "Copy current file relative path with line number to clipboard",
})

vim.api.nvim_create_user_command("CopyPathURL", function() require("cfp").copy_path_url() end, {
  desc = "Copy current file relative path with line number as GitHub URL to clipboard",
})

