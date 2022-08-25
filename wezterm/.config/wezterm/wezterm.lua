local wezterm = require("wezterm")

return {
	font = wezterm.font("JetBrains Mono"),
    font_size = 13,
    use_resize_increments = true,
    line_height = 1.0,
	color_scheme = "nightfox",
	audible_bell = "Disabled",
	window_background_image = wezterm.home_dir .. "/.config/wezterm/term_wallpaper.png",
	window_background_image_hsb = {
		brightness = 0.1,

		-- You can adjust the hue by scaling its value.
		-- a multiplier of 1.0 leaves the value unchanged.
		hue = 0.65,

		-- You can adjust the saturation also.
		saturation = 0.3,
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

	keys = {
		{ key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{
			key = "P",
			mods = "CTRL",
			action = wezterm.action.QuickSelectArgs({
				label = "open url",
				patterns = {
					"https?://\\S+",
				},
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.log_info("opening: " .. url)
					wezterm.open_with(url)
				end),
			}),
		},
		{
			key = "Z",
			mods = "CTRL",
			action = wezterm.action.TogglePaneZoomState,
		},
	},
}
