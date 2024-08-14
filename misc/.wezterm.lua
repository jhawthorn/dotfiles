-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Wombat'

config.window_decorations = "RESIZE"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.font = wezterm.font {
  family = 'Iosevka Nerd Font Mono',
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
}

-- config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.use_fancy_tab_bar = false

-- and finally, return the configuration to wezterm
return config
