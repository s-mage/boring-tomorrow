# Boring Tomorrow

Colors and highlight groups should be changed independently.

## Why

Author of this repo has strong opinions of what to highlight. There is [a blog post](https://smagin.fyi/posts/colorscheme/) about it, but here goes a short version.

When everything wants your attention, nothing gets it. Therefore, most of the things in your code should not be highlighed. Then you want to highlight things that you find important. My list is search terms, comments, linter errors, git diff, pair for the bracket under cursor.

Around the code is the editor interface. I'm a happy neovim user, so interface colors are another bunch of highlight groups. The main goal here is that code editor doesn't disturb you reading code, and that it's clear where one things ends and another thing starts.

Then there was a realisation that highlight groups (especially those that use only few colors) don't have to have those colors hardcoded. Terminals have color palettes since forever, and we want to rely on them, so that your neovim colors match other terminal apps colors, and that more people could try highlighting my way with colors their way.

## What

Two things, actualy. One is a terminal colorscheme. Wezterm to be specific, but there might be versions for other terminals in the future, if you send a patch.

The other is different apps and plugins specifying the terminal colors. There are neovim colors, and inside neovim there are fzf.vim and lualine plugins. fzf.nvim uses bat for previews, so there is a bat theme also that uses the same highlighting principles.

## Installation

Ideally the themes would be available to you where you usually pick them. I hope to get there, but until we're not, you have to link a bunch of files from these repo to your dotfiles, and then enable the themes.

### Clone and symlink

```sh
git clone https://github.com/s-mage/boring-tomorrow.git
cd boring-tomorrow

# wezterm
mkdir -p ~/.config/wezterm/colors
ln -sf "$PWD/wezterm/Boring Tomorrow.toml" ~/.config/wezterm/colors/"Boring Tomorrow.toml"

# neovim
mkdir -p ~/.config/nvim/lua/boring-tomorrow ~/.config/nvim/colors
ln -sf "$PWD/nvim/boring-tomorrow.lua" ~/.config/nvim/lua/boring-tomorrow/init.lua
ln -sf "$PWD/nvim/colors/boring-tomorrow.lua" ~/.config/nvim/colors/boring-tomorrow.lua

# bat, used separately and as nvim preview
mkdir -p "$(bat --config-dir)/themes"
ln -sf "$PWD/bat/Boring Tomorrow.tmTheme" "$(bat --config-dir)/themes/"
bat cache --build
bat --list-themes | grep "Boring Tomorrow" # verify
```

### wezterm

In `~/.config/wezterm/wezterm.lua` (or `~/.wezterm.lua`):

```lua
config.color_scheme = 'Boring Tomorrow'

-- don't dim bold:
config.bold_brightens_ansi_colors = false

-- use matching command palette colors:
config.command_palette_fg_color = "#000000"
config.command_palette_bg_color = "#efefef"
```

### nvim

In `~/.config/nvim/init.lua`:

```lua
require("boring-tomorrow").setup()
```

### fzf

FZF uses `FZF_DEFAULT_OPTS` ENV for default settings, so, in your `~/.bashrc`:

```
# -1 = terminal default, 5 = magenta, hl 3:bold = dark-yellow matches.
export FZF_DEFAULT_OPTS='--color=16,fg:-1,bg:-1,fg+:-1,bg+:-1,gutter:-1,border:-1,preview-border:-1,list-border:-1,separator:-1,scrollbar:-1,label:-1,list-label:-1,preview-label:-1,query:-1,prompt:-1,info:-1,header:-1,disabled:-1,preview-fg:-1,preview-bg:-1,list-fg:-1,list-bg:-1,spinner:5,pointer:-1,marker:-1,hl:3:bold,hl+:3:bold'
```

### bat

Set the theme globally (pick one — `BAT_THEME` overrides the config file):

```sh
echo '--theme="Boring Tomorrow"' >> "$(bat --config-file)"
# or: export BAT_THEME="Boring Tomorrow" # in .bashrc/.zshrc
```
