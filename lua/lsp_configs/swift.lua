local lspconfig = require("lspconfig")
local config = require("lspconfig.configs")

return function(on_attach)
	config.swift = {
		default_config = {
            cmd = { "sourcekit-lsp" },
            filetypes = { "swift" },
            root_dir = lspconfig.util.root_pattern("Package.swift"),
        }
	}

	lspconfig.swift.setup({ on_attach = on_attach })
end
