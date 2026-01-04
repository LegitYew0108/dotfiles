return{
	{
		'sainnhe/edge',
		lazy = false,
		priority = 1000,
		config = function()
			-- Optionally configure and load the colorscheme
			-- directly inside the plugin declaration.
			vim.g.edge_enable_italic = false
			vim.g.edge_style = 'neon'
			vim.cmd.colorscheme('edge')
		end
	},
	{
		'scottmckendry/cyberdream.nvim',
  	lazy = false,
  	priority = 1000,
	},
	{
		'sainnhe/everforest',
		lazy = false,
		priority = 1000,
	},
	{
		'folke/tokyonight.nvim',
		lazy = false,
		priority = 1000,
		opts = {},
	},
}
