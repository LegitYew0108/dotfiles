local format_group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })

vim.diagnostic.config({
  virtual_text = true,
})

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('clangd')
vim.lsp.enable('ts_ls')
vim.lsp.enable('html')
vim.lsp.enable('cssls')
vim.lsp.enable('tinymist')
vim.lsp.enable('cmake')

vim.lsp.config('rust_analyzer', {
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"
            },
        }
    }
})


vim.lsp.config('clangd',{
	cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
	init_options = { fallbackFlags = {'-std=c++17'},},
	root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
	filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
	on_attach = function(client, bufnr)
		-- clangdがformatter機能を持つか確認
		if client.supports_method('textDocument/formatting') then
			-- BufWritePreイベント(ファイル保存直前に)
			-- このバッファ(bufnr)に対してフォーマットを実行するautocmdを設定
			vim.api.nvim_create_autocmd('BufWritePre',{
				group = format_group,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({bufnr = bufnr})
				end,
			})
		end
	end,
})

vim.lsp.config('lua_ls',{
 settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        pathStrict = true,
        path = { "?.lua", "?/init.lua" },
      },
      workspace = {
        library = vim.list_extend(vim.api.nvim_get_runtime_file("lua", true), {
          "${3rd}/luv/library",
          "${3rd}/busted/library",
          "${3rd}/luassert/library",
        }),
        checkThirdParty = "Disable",
      },
    },
  },
})

vim.lsp.config('ts_ls',{
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript","javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_markers = {"package.json", ".git"},
})

vim.lsp.config('html',{
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_markers = {"package.json", ".git"},
})

vim.lsp.config('cssls',{
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css" },
	root_markers = {"package.json", ".git"},
})

vim.lsp.config("tinymist", {
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onType",
		semanticTokens = "disable",
	}
})
