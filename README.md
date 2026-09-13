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

TODO
