return{
	"lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
		vim.g.vimtex_compiler_latexmk = {continuous = 0}
		vim.g.vimtex_view_general_viewer = "qpdfview"
		vim.g.vimtex_view_general_options = '--unique @pdf\\#src:@tex:@line:@col'
  end
}
