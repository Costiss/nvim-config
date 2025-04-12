return {
	{
		"ramilito/kubectl.nvim",
		config = function()
			local kubectl = require("kubectl")
			kubectl.setup()

			local group = vim.api.nvim_create_augroup("kubectl_mappings", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = "k8s_*",
				callback = function(ev)
					local k = vim.keymap
					local opts = { buffer = ev.buf }

					k.set("n", "<C-e>", "<Plug>(kubectl.picker_view)", opts)
				end,
			})
			vim.keymap.set("n", "<leader>k", function()
				kubectl.toggle({ tab = true })
			end, { noremap = true, silent = true })
		end,
	},
}
