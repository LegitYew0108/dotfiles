local nvim_lsp = require('lspconfig')

local format_group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })

nvim_lsp.clangd.setup({
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
nvim_lsp.rust_analyzer.setup({})
nvim_lsp.ts_ls.setup({
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = { "javascript","javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_dir = nvim_lsp.util.root_pattern("package.json", ".git"),
})
nvim_lsp.html.setup{
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html" },
	root_dir = nvim_lsp.util.root_pattern("package.json", ".git"),
}
nvim_lsp.cssls.setup{
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css" },
	root_dir = nvim_lsp.util.root_pattern("package.json", ".git"),
}
nvim_lsp.lua_ls.setup({})
nvim_lsp.pyright.setup({})
