local lsp = require("lsp-zero")
require("mason").setup()
require("editorconfig")
vim.g.editorconfig = true

lsp.preset("recommended")
lsp.nvim_workspace()

-- Custom on_attach function
local function on_attach(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	local keymap = vim.keymap.set
	local lsp_buf = vim.lsp.buf
	local diagnostic = vim.diagnostic

	keymap("n", "gd", lsp_buf.definition, opts)
	keymap("n", "gtd", lsp_buf.type_definition, opts)
	keymap("n", "K", lsp_buf.hover, opts)
	keymap("n", "<leader>vws", lsp_buf.workspace_symbol, opts)
	keymap("n", "<leader>vd", diagnostic.open_float, opts)
	keymap("n", "[d", diagnostic.goto_next, opts)
	keymap("n", "]d", diagnostic.goto_prev, opts)
	keymap("n", "<leader>.", lsp_buf.code_action, opts)
	keymap("n", "<leader>vrr", lsp_buf.references, opts)
	keymap("n", "gA", lsp_buf.references, opts)
	keymap("n", "<leader>vrn", lsp_buf.rename, opts)
	keymap("n", "cd", lsp_buf.rename, opts)
	keymap("i", "<C-h>", lsp_buf.signature_help, opts)
end

-- Diagnostic configuration
vim.diagnostic.config({ virtual_text = true })

-- Load LSP configs
require("lsp_configs.swift")(on_attach)
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
require("lsp_configs.robot")(on_attach)
require("lsp_configs.metals")(on_attach)
require("lsp_configs.gradle")(on_attach)

-- Setup nvim-cmp

local lspkind = require("lspkind")
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<Tab>"] = cmp.mapping.confirm({ select = true }),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.close(),
})

lsp.setup_nvim_cmp({
	preselect = 1,
	mapping = cmp_mappings,
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
})
lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		sign_icons = {
			error = "✘",
			warn = "▲",
			hint = "⚑",
			info = "",
		},
	},
})

-- Your custom LSP settings here
lsp.on_attach(function(client, bufnr)
	-- Set custom diagnostic symbols
	local signs = { Error = "✘", Warn = "▲", Hint = "⚑", Info = "" }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- Configure diagnostic settings
	vim.diagnostic.config({
		virtual_text = {
			prefix = "●", -- Could be '●', '▎', 'x'
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
		float = {
			border = "rounded",
			source = "always",
		},
	})
end)

lsp.setup()
