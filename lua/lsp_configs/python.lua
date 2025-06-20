local lspconfig = require("lspconfig")
-- local mason_install = require("costis.helpers.mason_install")

return function(on_attach)
	-- mason_install({
	-- 	"basedpyright",
	-- })

	lspconfig.basedpyright.setup({
		on_attach = on_attach,
	})
end
