-- Pull in the wezterm API
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Alabaster'
config.font = wezterm.font 'Fira Code'
config.font_size = 13
config.line_height = 1.25

config.default_prog = { '/opt/homebrew/bin/bash' }
config.native_macos_fullscreen_mode = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_max_width = 35
config.window_decorations = "RESIZE"

config.keys = {
  { key = 'DownArrow', mods = 'CMD', action = wezterm.action.SpawnTab('CurrentPaneDomain'), },
  { key = 'l', mods = 'CMD', action = wezterm.action.ActivateCommandPalette, },
}

config.mouse_bindings = {
  -- Cmd-click will open the link under the mouse cursor
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  },
}

local boring_tomorrow_theme = {
  foreground = "#000000",
  background = "#ffffff",
  selection = "#efefef",
}

local boring_blue_theme = {
  foreground = "#000000",
  background = "#AFE9FF",
  selection = "#A9DDFF",
}

local theme = boring_blue_theme

config.window_frame = {
  -- The font used in the tab bar.
  font = wezterm.font { family = 'Fira Code', weight = 400 },
  font_size = 13.0,
  active_titlebar_bg = theme.selection,
  inactive_titlebar_bg = theme.background,
}

-- TODO: https://wezterm.org/config/appearance.html?h=colors#defining-a-color-scheme-in-a-separate-file
config.colors = {
  foreground = theme.foreground,
  background = theme.background,
  cursor_bg = theme.foreground,
  cursor_fg = theme.background,
  -- ansi = [
  --   "#050404",
  --   "#bd0013",
  --   "#4ab118",
  --   "#e7741e",
  --   "#0f4ac6",
  --   "#665993",
  --   "#70a598",
  --   "#f8dcc0",
  -- ]
  -- brights = [
  --   "#4e7cbf",
  --   "#fc5f5a",
  --   "#9eff6e",
  --   "#efc11a",
  --   "#1997c6",
  --   "#9b5953",
  --   "#c8faf4",
  --   "#f6f5fb",
  -- ]
  tab_bar = {
    inactive_tab_edge = theme.background,
    background = theme.background,
    new_tab = {
      bg_color = theme.background,
      fg_color = theme.foreground,
    },
    inactive_tab = {
      bg_color = theme.background,
      fg_color = theme.foreground,
    },
    active_tab = {
      bg_color = theme.selection,
      fg_color = theme.foreground,
    },
    new_tab_hover = {
      bg_color = theme.background,
      fg_color = theme.foreground,
    },
    inactive_tab_hover = {
      bg_color = theme.background,
      fg_color = theme.foreground,
    }
  },
}

config.command_palette_fg_color = theme.foreground

config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0.75cell',
  bottom = '0cell',
}

-- and finally, return the configuration to wezterm
return config
