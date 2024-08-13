local wezterm = require("wezterm")
local config = wezterm.config_builder()

local theme = "dark"

config.send_composed_key_when_left_alt_is_pressed = true -- Fix alt key not working as expected

config.color_scheme = (theme == "light") and "catppuccin-latte" or "catppuccin-mocha"

config.background = {
  {
    source = {
      File = wezterm.config_dir .. "/.assets/images/" .. ((theme == "light") and "chromatic_light_2.jpg" or "blue_distortion_1.jpg"),
    },
    horizontal_align = "Center",
    vertical_align = "Middle",
  },
  {
    source = {
      Color = (theme == "light") and "#ffffff" or "#010F14",
    },
    width = "100%",
    height = "100%",
    opacity = 0.75,
  },
}

return config
