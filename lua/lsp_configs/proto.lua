local lspconfig = require("lspconfig")
local config = require("lspconfig.configs")

return function()
	--https://github.com/lasorda/protobuf-language-server
	--brew install bufbuild/buf/buf

	vim.lsp.config("protobuf_language_server", {
		cmd = { "protobuf-language-server" },
		filetypes = { "proto", "cpp" },
		root_dir = require("lspconfig.util").root_pattern(".git"),
		single_file_support = true,
		settings = {},
	})

	vim.lsp.enable("protobuf_language_server")
	vim.lsp.enable("buf_ls")
end
