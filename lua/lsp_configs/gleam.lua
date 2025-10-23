local lspconfig = require("lspconfig")

return function(on_attach)
	vim.lsp.config("gleam", {
		cmd = { "gleam", "lsp" },
		filetypes = { "gleam" },
	})

	vim.lsp.enable("gleam")
end
