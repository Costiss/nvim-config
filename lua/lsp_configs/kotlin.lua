local lspconfig = require("lspconfig")
local conform = require("conform")
-- local mason_install = require("costis.helpers.mason_install")

return function(on_attach)
	-- mason_install({
	-- 	"kotlin-language-server",
	-- })

	conform.formatters_by_ft.kotlin = {
		"ktlint",
	}

	lspconfig.kotlin_language_server.setup({
		on_attach = on_attach,
	})
end
