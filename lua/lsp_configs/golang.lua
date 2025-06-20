local lspconfig = require("lspconfig")
local conform = require("conform")
-- local mason_install = require("costis.helpers.mason_install")

return function(on_attach)
	-- mason_install({
	-- 	"gopls",
	-- 	"goimports",
	-- })

	conform.formatters_by_ft.kotlin = {
		"goimports",
		"gofmt",
	}

	lspconfig.gopls.setup({
		on_attach = on_attach,
	})
end
