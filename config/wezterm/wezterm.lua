local wezterm = require 'wezterm';
local utils = require 'utils';

---------------------------------------------------------------
--- keybinds
---------------------------------------------------------------
local tmux_keybinds = {
    { key = "k", mods = "ALT", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "j", mods = "ALT", action = wezterm.action({ CloseCurrentTab = { confirm = false } }) },
	{ key = "h", mods = "ALT", action = wezterm.action({ ActivateTabRelative = -1 }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "h", mods = "ALT|CTRL", action = wezterm.action({ MoveTabRelative = -1 }) },
	{ key = "l", mods = "ALT|CTRL", action = wezterm.action({ ActivateTabRelative = 1 }) },
	{ key = "k", mods = "ALT|CTRL", action = "ActivateCopyMode" },
	{ key = "j", mods = "ALT|CTRL", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
	{ key = "1", mods = "ALT", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "ALT", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "ALT", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "ALT", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "ALT", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "ALT", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "ALT", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "ALT", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "ALT", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "-", mods = "ALT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "=", mods = "ALT", action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
	{ key = "h", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "l", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "k", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "j", mods = "ALT|SHIFT", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "h", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }) },
	{ key = "l", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }) },
	{ key = "k", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }) },
	{ key = "j", mods = "ALT|SHIFT|CTRL", action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }) },
	{ key = "c", mods = "ALT", action = "QuickSelect" },
}

local default_keybinds = {
	{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "Insert", mods = "SHIFT", action = wezterm.action({ PasteFrom = "PrimarySelection" }) },
	{ key = "=", mods = "CTRL", action = "ResetFontSize" },
	{ key = "+", mods = "CTRL", action = "IncreaseFontSize" },
	{ key = "-", mods = "CTRL", action = "DecreaseFontSize" },
	{ key = " ", mods = "CTRL|SHIFT", action = "QuickSelect" },
	{ key = "x", mods = "CTRL|SHIFT", action = "ActivateCopyMode" },
	{ key = "PageUp", mods = "ALT", action = wezterm.action({ ScrollByPage = -1 }) },
	{ key = "PageDown", mods = "ALT", action = wezterm.action({ ScrollByPage = 1 }) },
	{ key = "r", mods = "ALT", action = "ReloadConfiguration" },
	{ key = "r", mods = "ALT|SHIFT", action = wezterm.action({ EmitEvent = "toggle-tmux-keybinds" }) },
	{ key = "e", mods = "ALT", action = wezterm.action({ EmitEvent = "trigger-nvim-with-scrollback" }) },
	{ key = "x", mods = "ALT", action = wezterm.action({ CloseCurrentPane = { confirm = false } }) },
}

local function create_keybinds()
	return utils.merge_lists(default_keybinds, tmux_keybinds)
end

---------------------------------------------------------------
--- load local_config
---------------------------------------------------------------
-- Write settings you don't want to make public, such as ssh_domains
local function load_local_config()
	local ok, _ = pcall(require, "local")
	if not ok then
		return {}
	end
	return require("local").setup()
end
local local_config = load_local_config()

-- local M = {}
-- local local_config = {
-- 	ssh_domains = {
-- 		{
-- 			-- This name identifies the domain
-- 			name = "my.server",
-- 			-- The address to connect to
-- 			remote_address = "192.168.8.31",
-- 			-- The username to use on the remote host
-- 			username = "katayama",
-- 		},
-- 	},
-- }
-- function M.setup()
-- 	return local_config
-- end
-- return M

---------------------------------------------------------------
--- Config
---------------------------------------------------------------
local config = {
    font = wezterm.font_with_fallback({
        "Cica",
        {family="Iosevka Term", weight="Regular"},
        "Fire Code",
    }),
    use_ime = true,
    font_size = 14.2,
    color_scheme = "iceberg-dark",
    hide_tab_bar_if_only_one_tab = false,
    adjust_window_size_when_changing_font_size = false,
    window_background_opacity = 0.94,
	window_padding = {
		left = 5,
		right = 5,
		top = 0,
		bottom = 0,
	},
	tab_bar_at_bottom = true,
	disable_default_key_bindings = true,
    visual_bell = {
        fade_in_function = "EaseIn",
        fade_in_duration_ms = 120,
        fade_out_function = "EaseOut",
        fade_out_duration_ms = 120,
    },
    colors = {
        visual_bell = "#202020",
    },
    audible_bell = "Disabled",
    keys = create_keybinds(),
}

return utils.merge_tables(config, local_config)
