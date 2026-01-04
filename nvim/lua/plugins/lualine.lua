return{
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons', opt = true,
		'kdheepak/tabline.nvim',
	},
	config = function()
		local lualine = require('lualine')
		local colors = {
			blue   = '#6cb6eb',
			cyan   = '#5dbbc1',
			yellow = '#deb974',
			black  = '#202023',
			white  = '#c5cdd9',
			red    = '#ec7279',
			violet = '#ac83ba',
			green   = '#a0c980',
		}
		local bubbles_theme = {
			normal = {
				a = { fg = colors.black, bg = colors.green },
				b = { fg = colors.black, bg = colors.violet },
				c = { fg = colors.white },
			},

			insert = { a = { fg = colors.black, bg = colors.blue } },
			visual = { a = { fg = colors.black, bg = colors.yellow } },
			replace = { a = { fg = colors.black, bg = colors.red } },

			inactive = {
				a = { fg = colors.white, bg = colors.black },
				b = { fg = colors.white, bg = colors.black },
				c = { fg = colors.white },
			},
		}
		local config = {
		options = {
				icons_enabled = true,
				theme = bubbles_theme,
				component_separators = '',
				section_separators = { left = '', right = '' },
				disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = {'mode'},
			lualine_b = {'branch', 'diff', 'diagnostics'},
			lualine_c = {'filename'},
			lualine_x = {'encoding', 'fileformat', 'filetype'},
			lualine_y = {'progress'},
			lualine_z = {'location'}
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {'filename'},
			lualine_x = {'location'},
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {
			lualine_a = {'buffers'},
			lualine_b = {'branch'},
			lualine_c = {'filename'},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {'tabs'},
		},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	}
	lualine.setup(config)
end,
}
