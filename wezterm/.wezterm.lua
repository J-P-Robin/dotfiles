local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "catppuccin-mocha"

config.window_background_image = wezterm.config_dir .. "/.assets/images/darkcity.png"
config.window_background_image_hsb = {
  brightness = 0.15,
  saturation = 0.9,
}
config.colors = {
  background = '#010F14',
}

return config
