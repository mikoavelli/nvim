# Neovim Configuration

A modular, high-performance Neovim setup optimized for Python, C/C++, Rust, Lua, and Shell development.

Plugin management is handled by `lazy.nvim`, with automatic tool installation via `mason.nvim`, native project configuration resolution, and synchronous format-on-save.

---

## Features

- **Native Configuration Discovery**: Relies on external tools to perform native parent directory traversal to discover project configuration files.
- **LSP & Tool Management**:
  - Automatically installs and configures language servers via `mason-lspconfig.nvim`.
  - Automatically manages CLI formatters and linters via `mason.nvim`.
  - Enables LSP inlay hints by default across supported language servers.
- **Formatting & Linting**:
  - Synchronous format-on-save via `conform.nvim`.
  - Asynchronous linting on read and write via `nvim-lint`.
- **Completion System**:
  - `nvim-cmp` handles insert-mode completion with `cmp-nvim-lsp`.
  - `blink.cmp` provides command-line completion for commands and search buffers.
- **User Interface**:
  - Catppuccin Mocha palette integration across UI elements.
  - Mode-colored `lualine.nvim` statusline displaying branch, git diffs, LSP diagnostics, and status indicators.
  - Command-line popups and message routing via `noice.nvim`.
  - Visual notification popups via `snacks.nvim`.
  - Git decorations via `gitsigns.nvim` and keybinding documentation via `which-key.nvim`.

---

## Project Structure

```text
.
├── init.lua                # Entry point bootstrapping lazy.nvim and loading configurations
├── lazy-lock.json          # Lockfile pinning plugin commits
├── stylua.toml             # Lua formatting rules for StyLua
└── lua/
    ├── config/
    │   └── options.lua     # Global Neovim options, diagnostics, and autocommands
    └── plugins/
        ├── editor/
        │   ├── gitsigns.lua # Git decorations in the signcolumn
        │   └── whichkey.lua # Keymaps visual helper menu
        ├── lang/
        │   ├── blink.lua   # Command-line completion configuration
        │   ├── cmp.lua     # Insert-mode completion engine configuration
        │   ├── format.lua  # Formatters setup via conform.nvim
        │   ├── lint.lua    # Asynchronous linters setup via nvim-lint
        │   ├── lsp.lua     # LSP server setups and Mason handlers
        │   └── mason.lua   # External binary package installer
        └── ui/
            ├── colorscheme.lua # Catppuccin Mocha theme setup
            ├── lualine.lua     # Statusline configuration with mode colors
            ├── noice.lua       # Command-line and message replacement UI
            └── snacks.lua      # Notification popups
```

---

## Language Support Matrix

| Language | LSP Server | Formatter | Linter |
| :--- | :--- | :--- | :--- |
| **Python** | `basedpyright`, `ruff` | `ruff` (`ruff_fix`, `ruff_format`) | `ruff`, `mypy` |
| **C / C++** | `clangd` | `clang-format` | `clangd` (LSP) |
| **Rust** | `rust_analyzer` | `rust_analyzer` | `clippy` (via LSP) |
| **Lua** | `lua_ls` | `stylua` | `lua_ls` (LSP) |
| **Shell (sh/bash/zsh)** | — | `shfmt` | `shellcheck` |

---

## Usage

### 1. Clone the Repository

```bash
git clone https://github.com/user/nvim-config.git ~/.config/nvim
```

### 2. Launch Neovim

Execute Neovim to initialize `lazy.nvim` and install plugins:

```bash
nvim
```

---

## Configuration Reference

| File / Folder | Description |
| :--- | :--- |
| `init.lua` | Entry point bootstrapping `lazy.nvim` and importing plugin specs. |
| `lua/config/options.lua` | Options, diagnostics display, and tab/indent autocommands. |
| `lua/plugins/lang/` | Toolchain plugins (LSP, Mason, formatters, linters, completion). |
| `lua/plugins/ui/` | Visual components (Catppuccin, Lualine, Noice, Snacks). |
| `lua/plugins/editor/` | Editing tools (`gitsigns`, `which-key`). |

---

## Development

Static analysis and formatting commands for configuration files:

```bash
# Linting and formatting Lua code
stylua .

# Validate plugin configuration
nvim --headless "+Lazy! sync" +qa
```

---

## License

This project is open-source and released under the [MIT License](LICENSE).