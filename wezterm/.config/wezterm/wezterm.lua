local wezterm = require("wezterm")

return {
	font = wezterm.font("JetBrains Mono"),
	color_scheme = "nightfox",
	audible_bell = "Disabled",
	window_background_image = wezterm.home_dir .. "/.config/wezterm/term_wallpaper.png",
	window_background_image_hsb = {
		brightness = 0.1,

		-- You can adjust the hue by scaling its value.
		-- a multiplier of 1.0 leaves the value unchanged.
		hue = 1.0,

		-- You can adjust the saturation also.
		saturation = 1.0,
	},
	use_fancy_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	enable_tab_bar = false,
	default_prog = { "tmux", "new-session", "-A", "-s", "Main" },
	window_padding = {
		left = 2,
		right = 2,
		top = 2,
		bottom = 2,
	},
}
