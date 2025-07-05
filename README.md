# cfp.nvim

A Neovim plugin for easily copying file paths and GitHub URLs to clipboard.

## Features

- 📋 Copy current file relative path to clipboard
- 📍 Copy current file path with line number
- 🔗 Copy current file path as GitHub URL with line number
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
    copy_path_line = "<leader>cl",
    copy_path_url = "<leader>cu",
  },
})
```

To disable specific keymaps, set them to `nil`:

```lua
require("cfp").setup({
  keymaps = {
    copy_path = "<leader>cp",
    copy_path_line = nil,  -- disable this keymap
    copy_path_url = "<leader>cu",
  },
})
```

## Usage

### Commands

| Command | Description |
|---------|-------------|
| `:CopyPath` | Copy current file relative path to clipboard |
| `:CopyPathLine` | Copy current file relative path with line number to clipboard |
| `:CopyPathURL` | Copy current file relative path with line number as GitHub URL to clipboard |

### Default Keymaps

| Keymap | Command | Description |
|--------|---------|-------------|
| `<leader>cp` | `:CopyPath` | Copy file path |
| `<leader>cl` | `:CopyPathLine` | Copy file path with line number |
| `<leader>cu` | `:CopyPathURL` | Copy file path as GitHub URL |

## Example Output

- **CopyPath**: `lua/cfp/init.lua`
- **CopyPathLine**: `lua/cfp/init.lua:42`
- **CopyPathURL**: `https://github.com/tapihdev/cfp.nvim/blob/main/lua/cfp/init.lua#L42`

## License

Apache License 2.0