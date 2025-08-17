return{
	"lambdalisue/vim-fern",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"lambdalisue/glyph-palette.vim",
		"lambdalisue/vim-fern-renderer-nerdfont",
	},
	config = function()
		vim.g["fern#renderer"] = "nerdfont"
	end,
}
