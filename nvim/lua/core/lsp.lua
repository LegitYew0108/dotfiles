local format_group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })

vim.lsp.enable('rust_analyzer')
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')

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

vim.diagnostic.config({
  virtual_text = true,
})

