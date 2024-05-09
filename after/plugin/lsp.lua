if vim.g.vscode then
	-- VSCode extension
else
	local lsp = require("lsp-zero")
	require("mason").setup()

	require("editorconfig")
	vim.g.editorconfig = true

	lsp.nvim_workspace()
	lsp.preset("recommended")
	lsp.ensure_installed({
		"bufls",
		"tsserver",
		"eslint-lsp",
		"prettier",
		"efm",
		"prismals",
		"volar",
		"vtsls",
		"rust_analyzer",
		"gopls",
		"clangd",
		"tailwindcss",
		"html-lsp",
		"json-lsp",
		"docker_compose_language_service",
		"dockerls",
		"terraformls",
		"tflint",
		"lua_ls",
		"kotlin_language_server",
		"ktlint",
		"jdtls",
		"zls",
	})

	local cmp = require("cmp")
	local cmp_select = { behavior = cmp.SelectBehavior.Select }
	local cmp_mappings = lsp.defaults.cmp_mappings({
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<tab>"] = cmp.mapping.confirm({ select = true }),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
	})
	cmp_mappings["<Tab>"] = nil
	cmp_mappings["<S-Tab>"] = nil
	lsp.setup_nvim_cmp({
		preselect = 1,
		mapping = cmp_mappings,
	})
	lsp.set_preferences({
		suggest_lsp_servers = false,
		sign_icons = {
			error = "E",
			warn = "W",
			hint = "H",
			info = "I",
		},
	})
	lsp.on_attach(function(client, bufnr)
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
		vim.keymap.set("n", "<leader>.", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
	end)
	vim.diagnostic.config({
		virtual_text = true,
	})
	lsp.setup()
end
