-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font = wezterm.font("MesloLGS NF")
config.font_size = 12.0

config.use_ime = true

config.window_background_opacity = 0.85

config.window_decorations = 'RESIZE'
config.window_frame = {
 inactive_titlebar_bg = "none",
 active_titlebar_bg = "none",
}
config.window_background_gradient = {
	orientation = { Linear = { angle = -45.0 } },
	colors = { "000000","#404040"}
}
config.show_new_tab_button_in_tab_bar = false
config.colors = {
	tab_bar = {
		inactive_tab_edge = 'none',
	}
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
local SOLID_RIGHT_HONEYCOMB = wezterm.nerdfonts.ple_honeycomb
local SOLID_RIGHT_ICE_WAVEFORM = wezterm.nerdfonts.ple_ice_waveform
local SOLID_LEFT_ICE_WAVEFORM = wezterm.nerdfonts.ple_ice_waveform_mirrored
local SOLID_PIXEL_RIGHT = wezterm.nerdfonts.ple_pixelated_squares_big
local SOLID_PIXEL_LEFT = wezterm.nerdfonts.ple_pixelated_squares_big_mirrored

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
   local background = "#404040"
   local foreground = "#FFFFFF"
	 local edge_background = "none"

   if tab.is_active then
     background = "#8a2be2"
     foreground = "#FFFFFF"
   end

	 local edge_foreground = background

   local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

   return {
 		 { Background = { Color = edge_background } },
     { Foreground = { Color = edge_foreground } },
     { Text = SOLID_PIXEL_LEFT },
     { Background = { Color = background } },
     { Foreground = { Color = foreground } },
     { Text = title },
 		 { Background = { Color = edge_background } },
     { Foreground = { Color = edge_foreground } },
     { Text = SOLID_PIXEL_RIGHT },
   }
 end)

-- This is where you actually apply your config choises.

-- and finally, return the configuration to wezterm
return config
