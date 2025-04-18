return function(on_attach)
	local metals_config = require("metals").bare_config()
	metals_config.on_attach = function(client, bufnr)
		on_attach(client, bufnr)
	end

	-- Autocommand to initialize Metals on the specified filetypes
	local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "scala", "sbt", "java" },
		group = nvim_metals_group,
		callback = function()
			require("metals").initialize_or_attach(metals_config)
		end,
	})
end
