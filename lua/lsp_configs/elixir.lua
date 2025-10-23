local lspconfig = require("lspconfig")

return function(on_attach)
	vim.lsp.config("elixirls", {})
	vim.lsp.enable("elixirls")
end
