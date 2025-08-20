# cfp.nvim

A Neovim plugin for easily copying file paths and GitHub URLs to clipboard.

## Features

- 📋 Copy current file relative path to clipboard
- 📍 Copy current file path with line number
- 🔗 Copy current file path as GitHub URL (with branch or commit hash)
- 📍 Copy current file path as GitHub URL with line number (with branch or commit hash)
- ⚡ Simple and lightweight
- 🎨 Customizable keymaps

## Requirements

- Neovim >= 0.7.0
- Git (for GitHub URL functionality)

## Installation

### lazy.nvim

```lua
{
  "tapihdev/cfp.nvim",
  config = function()
    require("cfp").setup()
  end,
}
```

### packer.nvim

```lua
use {
  "tapihdev/cfp.nvim",
  config = function()
    require("cfp").setup()
  end,
}
```

## Configuration

Default configuration:

```lua
require("cfp").setup({
  keymaps = {
    copy_path = "<leader>cp",
    copy_path_line = "<leader>cP",
    copy_branch_url = "<leader>cb",
    copy_branch_url_line = "<leader>cB",
    copy_hash_url = "<leader>ch",
    copy_hash_url_line = "<leader>cH",
  },
})
```

To disable specific keymaps, set them to `nil`:

```lua
require("cfp").setup({
  keymaps = {
    copy_path = "<leader>cp",
    copy_path_line = nil,  -- disable this keymap
    copy_branch_url = "<leader>cb",
    copy_branch_url_line = nil,  -- disable this keymap
    copy_hash_url = "<leader>ch",
    copy_hash_url_line = "<leader>cH",
  },
})
```

## Usage

### Commands

| Command | Description |
|---------|-------------|
| `:CopyPath` | Copy current file relative path to clipboard |
| `:CopyPathLine` | Copy current file relative path with line number to clipboard |
| `:CopyBranchURL` | Copy current file relative path as GitHub URL with branch to clipboard |
| `:CopyBranchURLLine` | Copy current file relative path with line number as GitHub URL with branch to clipboard |
| `:CopyHashURL` | Copy current file relative path as GitHub URL with commit hash to clipboard |
| `:CopyHashURLLine` | Copy current file relative path with line number as GitHub URL with commit hash to clipboard |

### Default Keymaps

| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>cp` | `:CopyPath` | Copy file path |
| `<leader>cP` | `:CopyPathLine` | Copy file path with line number |
| `<leader>cb` | `:CopyBranchURL` | Copy file path as GitHub URL with branch |
| `<leader>cB` | `:CopyBranchURLLine` | Copy file path as GitHub URL with branch and line number |
| `<leader>ch` | `:CopyHashURL` | Copy file path as GitHub URL with commit hash |
| `<leader>cH` | `:CopyHashURLLine` | Copy file path as GitHub URL with commit hash and line number |

## Example Output

- **CopyPath**: `lua/cfp/init.lua`
- **CopyPathLine**: `lua/cfp/init.lua:42`
- **CopyBranchURL**: `https://github.com/tapihdev/cfp.nvim/blob/main/lua/cfp/init.lua`
- **CopyBranchURLLine**: `https://github.com/tapihdev/cfp.nvim/blob/main/lua/cfp/init.lua#L42`
- **CopyHashURL**: `https://github.com/tapihdev/cfp.nvim/blob/5e62bbb/lua/cfp/init.lua`
- **CopyHashURLLine**: `https://github.com/tapihdev/cfp.nvim/blob/5e62bbb/lua/cfp/init.lua#L42`

## License

Apache License 2.0