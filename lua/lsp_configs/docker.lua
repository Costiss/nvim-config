local lspconfig = require("lspconfig")

return function(on_attach)
	local function set_filetype(pattern, filetype)
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = pattern,
			command = "set filetype=" .. filetype,
		})
	end

	set_filetype({ "docker-compose.yml" }, "yaml.docker-compose")

	lspconfig.docker_compose_language_service.setup({
		on_attach = on_attach,
	})

	lspconfig.dockerls.setup({
		on_attach = on_attach,
	})
end
