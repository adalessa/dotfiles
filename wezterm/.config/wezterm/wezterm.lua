local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("update-right-status", function(window)
	window:set_right_status(window:active_workspace())
end)

return {
	-- General configuration
	audible_bell = "Disabled",
	window_close_confirmation = "NeverPrompt",
	use_fancy_tab_bar = false,
	enable_tab_bar = true,

	window_padding = {
		left = 2,
		right = 2,
		top = 2,
		bottom = 2,
	},

	-- Font and color scheme
	font = wezterm.font("JetBrains Mono"),
	font_size = 13,
	use_resize_increments = true,
	line_height = 1.0,
	color_scheme = "nightfox",

	-- Background
	window_background_image = wezterm.home_dir .. "/.config/wezterm/term_wallpaper.png",
	window_background_image_hsb = {
		brightness = 0.1,
		hue = 0.65,
		saturation = 0.3,
	},

	-- socket
	unix_domains = {
		{
			name = "unix",
		},
	},

	-- This causes `wezterm` to act as though it was started as
	-- `wezterm connect unix` by default, connecting to the unix
	-- domain on startup.
	-- If you prefer to connect manually, leave out this line.
	default_gui_startup_args = { "connect", "unix" },

	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		{ key = "=", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
		{
			key = "m",
			mods = "LEADER",
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
			key = "9",
			mods = "ALT",
			action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
		},
		{ key = "n", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(1) },
		{ key = "p", mods = "LEADER|CTRL", action = act.SwitchWorkspaceRelative(-1) },
		{
			key = "u",
			mods = "LEADER|CTRL",
			action = wezterm.action_callback(function(win, pane)
				-- here what I want have a project set or look for it
				-- so need to interact with workspaces
				--
				-- so need a child process that runs fzf base on the list and return the name and directory
				-- return as json {"name": "some name", "directory": "abs path", "group": "group"}
				-- not sure what to do do with group yet but better to have it
				-- local success, stdout, stderr = wezterm.run_child_process { 'ls', '-l' }
				-- act.SwitchToWorkspace {
				-- name = 'name',
				-- spawn = {
				--   cwd = 'path of the project',
				--   args = { 'nvim' },
				-- },
				-- },
				-- very important this how to sync with other funciton perform action from window
				-- win:perform_action(act.SwitchToWorkspace({
				-- 	name = "some test",
				-- 	spawn = {
				-- 		cwd = "/home/adalessa/code/php/carin-gateway-service/",
				-- 		args = { "nvim" },
				-- 	},
				-- }), pane)
			end),
		},
		{ key = "n", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "\\", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

		{ key = "a", mods = "LEADER|CTRL", action = act.ActivateLastTab },
		{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
		{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
		{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },

		{
			key = "h",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Left"),
		},
		{
			key = "l",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Right"),
		},
		{
			key = "k",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Up"),
		},
		{
			key = "j",
			mods = "LEADER",
			action = act.ActivatePaneDirection("Down"),
		},
	},
}
