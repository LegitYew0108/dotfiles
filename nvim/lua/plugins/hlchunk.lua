return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("hlchunk").setup({
			chunk = {
				enable = true,
				use_treesitter = true,
				style = {
					"#d38aea",
					"#ec7279"
				},
				notify = true,
				delay = 150,
			},
			indent = {
				enable = true,
			},
		})
	end
}
