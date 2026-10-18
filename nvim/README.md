# Neovim Configuration

This is a repository containing my personal Neovim configuration files. The
configuration in this repository full embrace the Lua configuration style and
are designed to work with Neovim 0.10+.

By using this configuration you will get an opinionated but efficient setup for
Neovim with sensible defaults and a focus on balancing performance and utility.
The plugins typically load in under 100ms which might increase if a specific
file type requires additional plugins to be loaded.

## Principles Behind Keymaps

A big part of being a neovim power user is to be able to navigate and edit
text efficiently. This by definition leads to the creation of many keymaps to
automate common tasks. The challenge is to create a set of keymaps that are
intuitive and easy to remember, while also being powerful and flexible.

The general principles behind the keymaps in this configuration are:

1. The `<leader>` key has been mapped to the spacebar so that subsequent keys
   can easily be accessed without having to stretch your fingers too far.

1. The key that immediately follows the `<leader>` key is a an
   `action identifier` - i.e., it is a mnemonic for the action that will be
   performed.

   The following table shows a list of identifiers. Note that each of the
   identifiers must be followed by a key or sequence of keys to perform an
   action.

   | Identifier  | Category Description                                                     |
   | ----------- | ------------------------------------------------------------------------ |
   | `<leader>f` | Find actions. Find files, commits, etc.                                  |
   | `<leader>h` | Git actions. Manage hunks, commit changes, etc.                          |
   | `<leader>a` | Ad actions. Generate code snippets, refactor code, etc.                  |
   | `<leader>b` | Action taken on the current buffer. Format, preview markdow, etc.        |
   | `<leader>s` | Search-related actions. Search for selected text, clear highlights, etc. |

   no follow on key sequences required to perform the action.

   | Dedicated Keymaps | Description                                                      |
   | ----------------- | ---------------------------------------------------------------- |
   | `<leader>?`       | Displays a list of all available keymaps for the current buffer. |
   | `<leader>w`       | Saves contents of all open tabs.                                 |
   | `<leader>r`       | Runs selected text or text on the current line                   |

# Getting Started

## Prerequisites

In theory, this configuration should work on any platform, but it has only been
tested on a Mac (Apple Silicon).

In order to start using this, you will need the following:

- Ideally a package manager like [Homebrew](https://brew.sh/). This is not
  strictly necessary, but it makes installing the required tools much easier.
- Neovim 0.10 or later. If you have homebrew installed, you can install
  Neovim with the following command:

### A Note on Font Based Icons

Some of the plugins in this configuration use font-based icons to make the
user interface more visually appealing. To use these icons, you will need
configure your terminal to use a Nerd Font. This is not strictly necessary, but
it might make your experience more enjoyable.

I recommend the `Sauce Code Pro` combined with [iterm2](https://iterm2.com/) on
macOS. The terminal can be configured to use the Nerd font for non-ASCII
characters, allowing you to choose the font of your choice for text displays.

```zsh
# Install neovim and a Nerd Font using Homebrew

brew install neovim font-sauce-code-pro-nerd-font
```

- You will also likely need a Node.js and a Python 3 environment for external
  tools used by the NeoVim plugins, though there are ways to work around this.
  On a development machine, I would recommend using
  [nvm](https://github.com/nvm-sh/nvm) for Node.js and
  [uv](https://docs.astral.sh/uv/) for Python 3.

  Alternatively, you can use a package manager to install most of these tools
  as binaries on your system. The choice is yours.

## Installation

Installing this configuration simply requires cloning the repository into your
config directory for Neovim. The default location for this on a Mac is
`~/.config/nvim`.

```zsh
git clone https://github.com/rishabhtole/nvim-config ~/.config/nvim
```

The editor configuration relies on a set of external tools to provide utilities
such as foramtting, file search, etc.

## External tools

### Formatters for different languages

- `stylua`: Formatter for Lua code. Useful when editing vim configuration files,
  or if you're a Lua developer.
- `prettier`: Formatter for JavaScript, TypeScript, HTML, CSS, and other web
  languages.
- `yapf`: A formatter for Python code.
- `rust toolchain` (optional): If you are a Rust developer, you can install
  the Rust toolchain using `rustup`. This will allow you to use the `rustfmt`
  formatter for Rust code. See
  [rust installation](https://www.rust-lang.org/tools/install) for more details.

### File Utilities

- `ripgrep`: A fast search tool written inr ust that is used for searching files
  in the project.
- `fd`: A fast alternative to `find` that is used for searching files in the
  project.
- `fzf`: A fuzzy finder that is used for searching files in a project.

### AI Helpers

- `mcphub`: Allows you to augment LLM agents with access to tools and services
  using the MCP protocol.

### Installing Tools

```zsh
# Install formatters and utilities
brew install stylua prettier ripgrep fd fzf yapf

# Install MCP Hub for AI helpers
npm install -g mcp-hub@latest
```
