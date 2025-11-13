return {
	{
		"ramilito/kubectl.nvim",
		-- use a release tag to download pre-built binaries
		version = "2.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		dependencies = "saghen/blink.download",
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
