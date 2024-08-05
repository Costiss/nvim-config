local lspconfig = require("lspconfig")

return function(on_attach)
	-- lspconfig.tsserver.setup({
	-- 	on_attach = nil,
	-- })

	lspconfig.vtsls.setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
	})

	lspconfig.volar.setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
	})

	lspconfig.prismals.setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
		end,
	})

	lspconfig.eslint.setup({
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "EslintFixAll",
			})
		end,
		settings = {
			eslint = {
				enable = true,
				format = { enable = true },
				packageManager = "npm",
				autoFixOnSave = true,
				codeActionsOnSave = {
					mode = "all",
					rules = { "!debugger", "!no-only-tests/*" },
				},
				lintTask = {
					enable = true,
				},
			},
		},
	})
end
