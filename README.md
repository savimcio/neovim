# Neovim Config

Personal Neovim setup built with [lazy.nvim](https://github.com/folke/lazy.nvim).

## Requirements

- Neovim >= 0.11
- Git
- A [Nerd Font](https://www.nerdfonts.com/) in your terminal (e.g. `FiraCode Nerd Font`)
- `ripgrep` — for Telescope live grep (`brew install ripgrep`)

## Install

### Fresh machine

```bash
git clone https://github.com/savimcio/neovim.git ~/.config/nvim
```

Open Neovim — lazy.nvim will auto-install all plugins on first launch.

### Replace existing config

```bash
mv ~/.config/nvim ~/.config/nvim.bak
git clone https://github.com/savimcio/neovim.git ~/.config/nvim
```

## Sync changes from another machine

```bash
git -C ~/.config/nvim pull
```

Then run `:Lazy sync` inside Neovim to install/remove plugin changes.

## Key bindings

Leader key: `Space`

| Key | Action |
|-----|--------|
| `` ` `` | Toggle floating terminal |
| `<leader><leader>` | Find files |
| `<leader>/` | Live grep |
| `<leader>e` | Recent files |
| `<leader>t` | Toggle file tree |
| `<leader>g` | LazyGit |
| `<leader>w` | Save |
| `<leader>q` | Quit |
| `<leader>a` | Code action |
| `<leader>f` | Format file |
| `<M-b>` | Go to definition |
| `<M-u>` | Find references |
| `K` | Hover docs |
| `<F2>` | Next diagnostic |
| `<F6>` | Rename symbol |
| `<F1>` | Cheatsheet |
| `<M-[>` / `<M-]>` | Prev / next buffer |
| `<M-w>` | Close buffer |
| `<C-h/j/k/l>` | Navigate splits |
