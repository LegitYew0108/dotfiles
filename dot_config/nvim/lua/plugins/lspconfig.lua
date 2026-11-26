return {
		{
			'cordx56/rustowl',
			version = '*', -- Latest stable version
			build = 'cargo install rustowl',
			lazy = false, -- This plugin is already lazy
			opts = {},
		},
    -- LSPの設定
    {'neovim/nvim-lspconfig'},
    -- cmp補完プラグインの設定
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",  -- LSP用補完ソース
            "hrsh7th/cmp-buffer",    -- バッファ内の補完
            "hrsh7th/cmp-path",      -- パス補完
            "saadparwaiz1/cmp_luasnip", -- スニペット用補完ソース
            "L3MON4D3/LuaSnip",      -- スニペットプラグイン
        },
        config = function()
            local cmp = require"cmp"
            cmp.setup({
                snippet = {
                    -- スニペットの設定（ここにLuaSnipの設定が入る場合が多い）
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- 前の補完候補
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- 次の補完候補
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),    -- ドキュメントを上スクロール
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),     -- ドキュメントを下スクロール
                    ["<C-w>"] = cmp.mapping.complete(),     -- 補完を呼び出す
                    ["<C-e>"] = cmp.mapping.close(),            -- 補完を閉じる
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enterで選択した補完を確定
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- LSPの補完
                }, {
                    { name = "buffer" },   -- バッファ内の補完
                })
            })
        end,
    },

    -- null-ls の設定 (フォーマッティングやLinting用)
    {
			"nvimtools/none-ls.nvim",
			dependencies={
				"nvim-lua/plenary.nvim",
				"nvimtools/none-ls-extras.nvim",
			},
			config = function()
				local format_group = vim.api.nvim_create_augroup('FormatOnSave', { clear = true })
				local null_ls = require("null-ls")
				null_ls.setup({
					sources = {
							-- 1. Formatter: Prettierd
							null_ls.builtins.formatting.prettierd,
							-- 2. Linter: ESLint_d
							require("none-ls.diagnostics.eslint_d"),
							-- 3. Code Action: ESLint_d
							require("none-ls.code_actions.eslint_d"),
					},
						-- 保存時に自動整形を走らせる設定
					on_attach = function(client, bufnr)
						if client.supports_method("textDocument/formatting") then
							vim.api.nvim_create_autocmd("BufWritePre", {
								group = format_group,
								buffer = bufnr,
								callback = function()
										vim.lsp.buf.format({ bufnr = bufnr, async = false })
								end,
							})
						end
					end,
				})
			end
    }
}
