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

			local group = vim.api.nvim_create_augroup('FernMyConf', {clear = true})


			local function set_fern_highlights()
				vim.api.nvim_set_hl(0, 'FernRootSymbol', { link = "Directory" })
				vim.api.nvim_set_hl(0, 'FernRootText', { link = "Directory" })
				vim.api.nvim_set_hl(0, 'FernBranchSymbol', { link = 'Directory' })
				vim.api.nvim_set_hl(0, 'FernBranchTextActive', { link = 'Directory' })
				vim.api.nvim_set_hl(0, 'FernBranchTextInactive', { link = 'Comment' })
				vim.api.nvim_set_hl(0, 'FernLeafSymbol', { link = "Normal" })
				vim.api.nvim_set_hl(0, 'FernLeafTextActive', { link = "Normal" })
				vim.api.nvim_set_hl(0, 'FernLeafTextInactive', { link = "Comment" })
			end
			set_fern_highlights()

			vim.api.nvim_create_autocmd('FileType', {
				group = group,
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
			vim.api.nvim_create_autocmd('VimEnter', {
				group = group,
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
				group = group,
				nested = true, --　必須
				callback = function()
					if vim.bo.filetype ~= "fern" and vim.bo.buftype == "" then
						vim.cmd [[Fern . -reveal=% -drawer -stay]]
					end
				end
			})
			vim.api.nvim_create_autocmd('WinEnter', {
				group = group,
				callback = function()
					if vim.bo.filetype == "fern" then
						if vim.g["should_reload_fern"] then
							vim.g["should_reload_fern"] = false
							vim.api.nvim_input("<F5>")
						end
						vim.wo.winhighlight = table.concat({
							"FernBranchText:FernBranchTextActive",
							"FernLeafText:FernLeafTextActive"
						},",")
					end
				end
			})

			vim.api.nvim_create_autocmd('WinLeave', {
				group = group,
				callback = function()
					if vim.bo.filetype == "fern" then
						vim.wo.winhighlight = table.concat({
							"FernBranchText:FernBranchTextInactive",
							"FernLeafText:FernLeafTextInactive"
						},",")
					end
				end
			})

			vim.api.nvim_create_autocmd("ColorScheme", {
				group = group,
				callback = set_fern_highlights
			})
		end,
	}
}
