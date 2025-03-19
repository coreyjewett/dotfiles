-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- disable ligatures
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }

config.font = wezterm.font("MesloLGS Nerd Font")

config.window_background_opacity = 0.9

-- stop faat-fingering windows closed
config.keys = {
  {
    key = 'w',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentTab { confirm = true },
  },
}
config.skip_close_confirmation_for_processes_named = { }

config.front_end = "WebGpu"

-- and finally, return the configuration to wezterm
return config
