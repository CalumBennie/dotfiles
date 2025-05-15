-- Pull the wezterm API
local wezterm = require("wezterm")
-- Create a variable to hold the configuration
local config = wezterm.config_builder()

-- Spawn a fish shell in login mode
config.default_prog = { "/usr/bin/fish", "-l" }

-- Change the window geometry
config.initial_cols = 120
config.initial_rows = 20

-- Change the font
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium", stretch = "Normal", style = "Normal" })
config.font_size = 11

-- Change the colour scheme
config.color_scheme = "Catppuccin Mocha"

-- Finally return the configuration
return config
