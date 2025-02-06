local lspconfig = require("lspconfig")
local config = require("lspconfig.configs")

return function(on_attach)
	--https://github.com/lasorda/protobuf-language-server

	config.protobuf_language_server = {
		default_config = {
			cmd = { "protobuf-language-server" },
			filetypes = { "proto", "cpp" },
			root_dir = lspconfig.util.root_pattern(".git"),
			single_file_support = true,
			settings = {},
		},
	}

	lspconfig.protobuf_language_server.setup({ on_attach = on_attach })
end
