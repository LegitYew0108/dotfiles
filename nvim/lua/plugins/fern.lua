return{
	{
		"lambdalisue/vim-fern",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"lambdalisue/vim-glyph-palette",
			"lambdalisue/vim-fern-renderer-nerdfont",
			"TheLeoP/fern-renderer-web-devicons.nvim",
			"yuki-yano/fern-preview.vim",
		},
		config = function()
			vim.g["fern#renderer"] = "nvim-web-devicons"
			vim.g["fern#default_hidden"] = 1
			vim.g["fern#hide_cursor"] = true
			vim.g["glyph_palette#palette"] = require 'fr-web-icons'.palette()
			vim.fn['glyph_palette#apply']()

			vim.api.nvim_create_augroup('FernMyConf', {})
			local ns = vim.api.nvim_create_namespace("fern-colors")

			local colors = {
				bg_dim = "#252630",
				bg0 = "#2b2d3a",
				bg1 = "#333648",
				bg2 = "#363a4e",
				bg3 = "#393e53",
				bg4 = "#3f445b",
				fg = "#c5cdd9",
				blue = "#6cb6eb",
				bg_blue = "#354157",
				yellow = "#deb974",
				grey_dim = "#535c6a"
			}

			vim.api.nvim_create_autocmd('FileType', {
				pattern = 'fern',
				callback = function(args)
					-- 相対と絶対の両方の行番号をオフにする
					vim.opt_local.relativenumber = false
					vim.opt_local.number = false
					vim.opt_local.signcolumn = 'no'
					vim.opt_local.foldcolumn = "0"
					vim.fn['glyph_palette#apply']()
					vim.keymap.set('n', 'p', '<Plug>(fern-action-preview:auto:toggle)', { buffer = true })
					vim.keymap.set("n","ff","<cmd>Fern . -reveal=% -drawer -toggle<CR>", { buffer = true })
				end
			})
			vim.api.nvim_create_autocmd('User', {
				group = 'FernMyConf',
				pattern = 'FernHighlight',
				callback = function()
					vim.api.nvim_win_set_hl_ns(0, ns)
					vim.api.nvim_set_hl(ns, 'FernBranchSymbol', { link = 'Directory' })
					vim.api.nvim_set_hl(ns, 'FernBranchText', { link = 'Directory' })
					vim.api.nvim_set_hl(ns, 'CursorLine', {
						fg = colors.yellow,
						bg = colors.bg3,
					})
				end
			})
			vim.api.nvim_create_autocmd('VimEnter', {
				group = 'FernMyConf',
				nested = true,
				callback = function(args)
					if vim.fn.argc() > 0 then
						vim.cmd[[Fern . -reveal=% -drawer -toggle -stay]]
					else
						vim.cmd[[Fern . -reveal=% -drawer -toggle]]
					end
				end
			})
			vim.api.nvim_create_autocmd('BufRead', {
				group = 'FernMyConf',
				nested = true, --　必須
				callback = function()
					if vim.bo.filetype ~= "fern" and vim.bo.buftype == "" then
						vim.cmd [[Fern . -reveal=% -drawer -stay]]
					end
				end
			})
			vim.api.nvim_create_autocmd('BufEnter', {
				group = 'FernMyConf',
				callback = function(args)
					if vim.bo.filetype == "fern" then
						if vim.g["should_reload_fern"] then
							vim.g["should_reload_fern"] = false
							vim.api.nvim_input("<F5>")
						end
						vim.api.nvim_win_set_hl_ns(0, ns)
						vim.api.nvim_set_hl(ns, 'FernRootSymbol', { fg = colors.yellow })
						vim.api.nvim_set_hl(ns, 'FernRootText', { fg = colors.yellow })
						vim.api.nvim_set_hl(ns, 'FernBranchSymbol', { link = 'Directory' })
						vim.api.nvim_set_hl(ns, 'FernBranchText', { link = 'Directory' })
						vim.api.nvim_set_hl(ns, 'FernLeafText', { fg = colors.fg })
						vim.api.nvim_set_hl(ns, 'Normal', {
							bg = colors.bg_dim,
						})
						vim.api.nvim_set_hl(ns, 'FoldColumn', {
							bg = colors.blue,
						})
						vim.api.nvim_set_hl(ns, 'EndOfBuffer', {
							bg = colors.bg_dim,
							fg = colors.bg_dim
						})
						vim.api.nvim_set_hl(ns, 'CursorLine', {
							fg = colors.yellow,
							bg = colors.bg4,
						})
					end
				end
			})

			vim.api.nvim_create_autocmd('BufLeave', {
				group = 'FernMyConf',
				callback = function(args)
					if vim.bo.filetype == "fern" then
						vim.api.nvim_set_hl(ns, 'FernRootSymbol', { fg = colors.fg })
						vim.api.nvim_set_hl(ns, 'FernRootText', { fg = colors.fg })
						vim.api.nvim_set_hl(ns, 'FernBranchSymbol', { fg = colors.fg })
						vim.api.nvim_set_hl(ns, 'FernBranchText', { fg = colors.fg })
						vim.api.nvim_set_hl(ns, 'FernLeafText', { fg = colors.fg })
						vim.api.nvim_win_set_hl_ns(0, ns)
						vim.api.nvim_set_hl(ns, 'Normal', {
							bg = colors.bg0,
						})
						vim.api.nvim_set_hl(ns, 'EndOfBuffer', {
							bg = colors.bg0,
							fg = colors.bg0
						})
						vim.api.nvim_set_hl(ns, 'CursorLine', {
							fg = colors.yellow,
							bg = colors.bg4,
						})
					end
				end
			})
		end,
	}
}
