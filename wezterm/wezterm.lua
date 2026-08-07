-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.use_ime = true
config.font = wezterm.font("0xProto Nerd Font")
config.font_size = 16.0

config.window_decorations = 'RESIZE'
config.window_frame = {
 inactive_titlebar_bg = "none",
 active_titlebar_bg = "none",
}
config.color_scheme = 'nightfox'
config.show_new_tab_button_in_tab_bar = true

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
local SOLID_RIGHT_HONEYCOMB = wezterm.nerdfonts.ple_honeycomb
local SOLID_RIGHT_ICE_WAVEFORM = wezterm.nerdfonts.ple_ice_waveform
local SOLID_LEFT_ICE_WAVEFORM = wezterm.nerdfonts.ple_ice_waveform_mirrored
local SOLID_PIXEL_RIGHT = wezterm.nerdfonts.ple_pixelated_squares_big
local SOLID_PIXEL_LEFT = wezterm.nerdfonts.ple_pixelated_squares_big_mirrored

wezterm.on("format-tab-title", function(tab, tabs, panes, config_internal, hover, max_width)
	 local scheme = wezterm.color.get_builtin_schemes()[config.color_scheme]
   local background = scheme.ansi[1]
   local foreground = scheme.foreground
	 local edge_background = "none"

   if tab.is_active then
     background = scheme.ansi[5]
     foreground = scheme.foreground
   end

	 local edge_foreground = background

   local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

   return {
 		 { Background = { Color = edge_background } },
     { Foreground = { Color = edge_foreground } },
     { Text = SOLID_LEFT_ARROW },
     { Background = { Color = background } },
     { Foreground = { Color = foreground } },
     { Text = title },
 		 { Background = { Color = edge_background } },
     { Foreground = { Color = edge_foreground } },
     { Text = SOLID_RIGHT_ARROW },
   }
 end)

wezterm.on('update-status', function(window, pane)
  window:set_right_status(wezterm.format {
    { Text = wezterm.strftime '%Y-%m-%d %H:%M ' },
  })
end)

return config
