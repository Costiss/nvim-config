local lspconfig = require("lspconfig")
local mason_install = require("lsp_configs.helpers.mason_install")

return function(on_attach)
	mason_install({
		"docker-compose-language-service",
		"dockerfile-language-server",
	})

	local function set_filetype(pattern, filetype)
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = pattern,
			command = "set filetype=" .. filetype,
		})
	end

	set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")
	set_filetype({ "*Dockerfile*" }, "dockerfile")

	lspconfig.docker_compose_language_service.setup({
		on_attach = on_attach,
	})

	lspconfig.dockerls.setup({
		on_attach = on_attach,
	})
end
