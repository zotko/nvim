# Neovim Configuration

A personal Neovim configuration based on NvChad v2.5 with custom plugins and settings.

## Overview

This configuration uses NvChad as a base and extends it with additional plugins and custom configurations.

## Features

### Theme
- **Gruvbox Light** theme with auto dark mode support
- Automatic theme switching based on system appearance (macOS)

### LSP Servers
Configured language servers via Mason:
- **Python**: Pyright (with relaxed type checking)
- **Lua**: lua-language-server
- **HTML**: html-lsp
- **CSS**: css-lsp

### Code Formatting
Format on save enabled with conform.nvim for:
- **Lua**: stylua
- **CSS/HTML**: prettier
- **JavaScript/React**: prettier
- **JSON**: prettier

### Plugins
- **nvim-lspconfig**: LSP configuration
- **conform.nvim**: Code formatting
- **aerial.nvim**: Code outline and symbol navigation
- **dressing.nvim**: Improved UI for vim.ui interfaces
- **vim-fugitive**: Git integration
- **auto-dark-mode.nvim**: Automatic theme switching
- **nvim-treesitter**: Syntax highlighting and code folding

### Custom Settings
- Treesitter-based code folding enabled
- Folds open by default (foldlevel=99)
- Space as leader key

## Structure

```
.
├── init.lua                   # Entry point
├── lua/
│   ├── options.lua           # Custom vim options
│   ├── mappings.lua          # Custom keymappings
│   ├── autocmds.lua          # Auto commands
│   ├── chadrc.lua            # NvChad configuration
│   ├── plugins/
│   │   └── init.lua          # Plugin specifications
│   └── configs/
│       ├── lspconfig.lua     # LSP configurations
│       ├── conform.lua       # Formatter settings
│       ├── treesitter.lua    # Treesitter config
│       ├── aerial.lua        # Aerial config
│       ├── auto_dark_mode.lua # Dark mode config
│       └── lazy.lua          # Lazy.nvim settings
└── README.md
```

## Installation

1. Backup your existing Neovim configuration
2. Clone this repository to `~/.config/nvim`
3. Launch Neovim - plugins will install automatically
4. Run `:MasonInstallAll` to ensure all tools are installed

## Credits

- [NvChad](https://github.com/NvChad/NvChad) - Base configuration framework
- [LazyVim starter](https://github.com/LazyVim/starter) - Inspired NvChad's starter template
