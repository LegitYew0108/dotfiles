local nvim_lsp = require('lspconfig')

nvim_lsp.clangd.setup({})
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
nvim_lsp.pyright.setup({})
