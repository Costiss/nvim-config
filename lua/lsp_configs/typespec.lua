local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function(on_attach)
	mason_install({
		"tsp-server",
	})

	lspconfig.typespec.setup({
		on_attach = on_attach,
	})
end
