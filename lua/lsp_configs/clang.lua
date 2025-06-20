local lspconfig = require("lspconfig")
local mason_install = require("costis.helpers.mason_install")

return function(on_attach)
	mason_install({
		"clangd",
	})

	lspconfig.clangd.setup({
		on_attach = function(client, bufnr)
			local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

			local disabled_filetypes = { "proto" }

			if vim.tbl_contains(disabled_filetypes, filetype) then
				vim.lsp.stop_client(client.id)
			else
				on_attach(client, bufnr)
			end
		end,
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "c++" },
	})
end
