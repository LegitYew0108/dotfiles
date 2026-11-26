return{
    "nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
    build = ":TSUpdate",
    config = function () 
      local treesitter = require("nvim-treesitter")

			treesitter.setup()

			treesitter.install({"c", "lua", "vim", "elixir", "rust", "typescript", "javascript", "html"})
    end
 }
