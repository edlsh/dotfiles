# 🏠 Dotfiles

Personal dotfiles managed with [chezmoi](https://chezmoi.io/).

## 🚀 Quick Install (New Machine)

```bash
# One-liner bootstrap
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply enzolucchesi

# Or step by step
brew install chezmoi
chezmoi init https://github.com/enzolucchesi/dotfiles.git
chezmoi diff     # Preview changes
chezmoi apply    # Apply changes
```

## 📦 What's Included

### Shell
- **zsh** - Main shell with zinit plugin manager
- **bash** - Backup shell config
- **starship** - Cross-shell prompt
- **atuin** - Shell history sync

### Terminal & Editor
- **nvim** - Neovim with LazyVim
- **ghostty** - Terminal emulator
- **tmux** - Terminal multiplexer

### Development Tools
- **git** - Git configuration
- **mise** - Runtime version manager
- **fish** - Alternative shell config

### Utilities
- **btop** - System monitor
- **yazi** - Terminal file manager
- **broot** - Directory navigator

## 🔐 Secrets Management

API keys are stored in **1Password** and loaded via `op run`:

```bash
# Secrets reference file (not tracked)
~/.secrets/op.env

# Usage
op run --env-file ~/.secrets/op.env -- <command>
```

## 📋 Daily Commands

```bash
chezmoi edit ~/.zshrc     # Edit a dotfile
chezmoi diff              # See pending changes
chezmoi apply             # Apply changes
chezmoi update            # Pull & apply from git
chezmoi re-add            # Re-add modified files
chezmoi cd                # Go to source directory
```

## 🖥️ Machine-Specific Config

Edit `~/.config/chezmoi/chezmoi.toml` for machine-specific settings:

```toml
[data]
    name = "Your Name"
    email = "you@example.com"
    github_username = "username"
```

## 📁 Structure

```
~/.local/share/chezmoi/
├── .chezmoi.toml.tmpl    # Config template
├── .chezmoiignore        # Files to ignore
├── dot_zshrc             # → ~/.zshrc
├── dot_bashrc.tmpl       # → ~/.bashrc (templated)
├── dot_gitconfig         # → ~/.gitconfig
├── dot_tmux.conf         # → ~/.tmux.conf
└── dot_config/           # → ~/.config/
    ├── nvim/
    ├── ghostty/
    ├── starship.toml
    └── ...
```

---
*Managed with ❤️ and [chezmoi](https://chezmoi.io/)*
