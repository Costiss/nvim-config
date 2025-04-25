local lspconfig = require("lspconfig")
local conform = require("conform")
local mason = require("mason")

return function(on_attach)
	mason.setup({
		ensure_installed = {
			"basedpyright",
		},
	})
	--
	-- conform.formatters_by_ft.python = {
	-- 	"black",
	-- }

	lspconfig.basedpyright.setup({
		on_attach = on_attach,
	})
end
