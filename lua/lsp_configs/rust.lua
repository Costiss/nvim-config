local lspconfig = require("lspconfig")

return function(on_attach)
	vim.lsp.config("rust_analyzer", {})

	vim.lsp.enable("rust_analyzer")
end
