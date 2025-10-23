return {
	{
		"numToStr/Comment.nvim",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			--require("Comment").setup()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v4.x",
		dependencies = {
			----------- OPTIONALS -------------------
			-- This tiny plugin adds vscode-like pictograms to neovim built-in lsp
			"onsails/lspkind.nvim",
			-- UI
			"stevearc/dressing.nvim",
			--------------------------------------
			"neovim/nvim-lspconfig", -- Required
			"hrsh7th/nvim-cmp", -- Required
			"hrsh7th/cmp-nvim-lsp", -- Required
			"L3MON4D3/LuaSnip", -- Required
		},
		config = function()
			-- Diagnostic configuration (keep this part)
			local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "" }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				virtual_text = {
					prefix = "●",
					spacing = 4,
					source = "always",
					format = function(diagnostic)
						return string.format("%s (%s)", diagnostic.message, diagnostic.source)
					end,
				},
				signs = true,
				underline = true,
				update_in_insert = false,
				severity_sort = true,
				float = { border = "rounded", source = "always" },
			})

			-- New LspAttach handler instead of on_attach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("user-lsp", {}),
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					local opts = { buffer = bufnr, remap = false }
					local keymap = vim.keymap.set

					keymap("n", "gd", vim.lsp.buf.definition, opts)
					keymap("n", "gtd", vim.lsp.buf.type_definition, opts)
					keymap("n", "K", vim.lsp.buf.hover, opts)
					keymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
					keymap("n", "<leader>vd", vim.diagnostic.open_float, opts)
					keymap("n", "[d", vim.diagnostic.goto_next, opts)
					keymap("n", "]d", vim.diagnostic.goto_prev, opts)
					keymap("n", "<leader>.", function()
						vim.lsp.buf.code_action({
							context = {
								diagnostics = vim.lsp.diagnostic.get_line_diagnostics(),
								triggerKind = vim.lsp.protocol.CodeActionTriggerKind.Invoked,
							},
						})
					end, opts)
					keymap("n", "<leader>vrr", vim.lsp.buf.references, opts)
					keymap("n", "gA", vim.lsp.buf.references, opts)
					keymap("n", "<leader>vrn", vim.lsp.buf.rename, opts)
					keymap("n", "cd", vim.lsp.buf.rename, opts)
					keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				end,
			})

			local on_attach = function(client, bufnr) end
			require("lsp_configs.clang")(on_attach)
			require("lsp_configs.elixir")(on_attach)
			require("lsp_configs.gleam")(on_attach)
			require("lsp_configs.javascript")(on_attach)
			require("lsp_configs.jdtls")(on_attach)
			require("lsp_configs.kotlin")(on_attach)
			require("lsp_configs.lua")(on_attach)
			require("lsp_configs.rust")(on_attach)
			require("lsp_configs.terraform")(on_attach)
			require("lsp_configs.zig")(on_attach)
			require("lsp_configs.golang")(on_attach)
			require("lsp_configs.gradle")(on_attach)
			require("lsp_configs.proto")(on_attach)
			require("lsp_configs.docker")(on_attach)
			require("lsp_configs.python")(on_attach)
			require("lsp_configs.json")(on_attach)
			require("lsp_configs.dart")(on_attach)
			require("lsp_configs.kube")(on_attach)

			local cmp = require("cmp")
			local lspkind = require("lspkind")

			cmp.setup({
				preselect = cmp.PreselectMode.Item,
				mapping = {
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						menu = {
							buffer = "[Buffer]",
							nvim_lsp = "[LSP]",
							luasnip = "[LuaSnip]",
							nvim_lua = "[Lua]",
							latex_symbols = "[Latex]",
						},
					}),
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					-- Add other sources as needed
				},
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", { capabilities = capabilities })
		end,
	},
}
