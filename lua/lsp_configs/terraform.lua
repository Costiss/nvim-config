local lspconfig = require("lspconfig")
-- local mason_install = require("costis.helpers.mason_install")

return function(on_attach)
	-- mason_install({
	-- 	"terraform-ls",
	-- 	"tflint",
	-- })

	lspconfig.terraformls.setup({
		on_attach = on_attach,
	})

	lspconfig.tflint.setup({
		on_attach = on_attach,
	})
end
