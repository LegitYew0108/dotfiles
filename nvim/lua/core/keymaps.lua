vim.keymap.set("i","jj","<ESC>")

vim.keymap.set("n","<A-1>",":LualineBuffersJump 1<CR>")
vim.keymap.set("n","<A-2>",":LualineBuffersJump 2<CR>")
vim.keymap.set("n","<A-3>",":LualineBuffersJump 3<CR>")
vim.keymap.set("n","<A-4>",":LualineBuffersJump 4<CR>")
vim.keymap.set("n","<A-5>",":LualineBuffersJump 5<CR>")
vim.keymap.set("n","<A-6>",":LualineBuffersJump 6<CR>")
vim.keymap.set("n","<A-7>",":LualineBuffersJump 7<CR>")
vim.keymap.set("n","<A-8>",":LualineBuffersJump 8<CR>")
vim.keymap.set("n","<A-9>",":LualineBuffersJump 9<CR>")

vim.keymap.set("n","ff",":Fern . -drawer<CR>")

vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<CR>")
vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<CR>")
vim.keymap.set('n', '<leader>fb', "<cmd>Telescope builtin.buffers<CR>")
vim.keymap.set('n', '<leader>fh', "<cmd>Telescope builtin.help_tags<CR>")

vim.keymap.set('n', 'tt', "<cmd>ToggleTerm<CR>")

-- LSPサーバアタッチ時の処理
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ctx)
    local set = vim.keymap.set
    set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = true })
    set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = true })
    set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = true })
    set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = true })
    set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = true })
    set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", { buffer = true })
    set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", { buffer = true })
    set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", { buffer = true })
    set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = true })
    set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = true })
    set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = true })
    set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = true })
    set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", { buffer = true })
    set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", { buffer = true })
    set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", { buffer = true })
    set("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", { buffer = true })
    set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", { buffer = true })
  end,
})
