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

	vim.lsp.config("docker_compose_language_service", {})
	vim.lsp.enable("docker_compose_language_service")

	vim.lsp.config("dockerls", {})
	vim.lsp.enable("dockerls")
end
