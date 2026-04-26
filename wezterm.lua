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

-- Register external color scheme directory
local colors_dir = wezterm.home_dir .. '/opensource/boring-tomorrow/colors'
config.color_scheme_dirs = { colors_dir }

-- Set the color scheme to the one we just defined
local theme_name = 'Boring Tomorrow'
config.color_scheme = theme_name

-- Retrieve the loaded scheme so we can pull values from it for UI elements below
local theme = wezterm.color.get_builtin_schemes()[theme_name] 
if not theme then
    -- Fallback to our custom scheme parsing since it might not be in builtin yet
    local scheme_file = io.open(colors_dir .. '/' .. theme_name .. '.toml', "r")
    if scheme_file then scheme_file:close() end
    -- Note: wezterm handles the colors internally based on color_scheme
end

-- We will extract just the core values to keep the UI styling working
local ui_bg = "#ffffff"
local ui_selection = "#efefef"
local ui_fg = "#000000"

config.window_frame = {
  -- The font used in the tab bar.
  font = wezterm.font { family = 'Fira Code', weight = 400 },
  font_size = 13.0,
  active_titlebar_bg = ui_selection,
  inactive_titlebar_bg = ui_bg,
}

-- The terminal UI elements below are configured manually, as Wezterm's toml doesn't strictly cover tab_bar objects natively inside the [colors] block yet.
-- They are mostly white/grey. The core 256 ansi colors will come from `Boring Tomorrow.toml` auto-loaded via color_scheme config above!
config.colors = {
  tab_bar = {
    inactive_tab_edge = ui_bg,
    background = ui_bg,
    new_tab = {
      bg_color = ui_bg,
      fg_color = ui_fg,
    },
    inactive_tab = {
      bg_color = ui_bg,
      fg_color = ui_fg,
    },
    active_tab = {
      bg_color = ui_selection,
      fg_color = ui_fg,
    },
    new_tab_hover = {
      bg_color = ui_bg,
      fg_color = ui_fg,
    },
    inactive_tab_hover = {
      bg_color = ui_bg,
      fg_color = ui_fg,
    }
  },
}

config.command_palette_fg_color = ui_fg

config.window_padding = {
  left = '0cell',
  right = '0cell',
  top = '0.75cell',
  bottom = '0cell',
}

-- and finally, return the configuration to wezterm
return config
