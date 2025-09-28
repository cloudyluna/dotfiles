local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local home = os.getenv('HOME')


config.enable_scroll_bar = true
config.initial_cols = 120
config.initial_rows = 28
config.font = wezterm.font 'Fira Code'
config.font_size = 12

-- TODO: Bundle the wallpapers.
config.window_background_image = home .. '/Pictures/wallpaper/The-Elder-Scrolls-V-Skyrim-PS4-Wallpapers-12.jpg'
config.window_background_image_hsb = {
    brightness = 0.02,
    hue = 0.7,
    saturation = 1.0,
}
config.window_close_confirmation = 'AlwaysPrompt'

return config
