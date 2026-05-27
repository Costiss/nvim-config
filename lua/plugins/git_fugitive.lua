return {
	{
		"tpope/vim-fugitive",
		config = function()
			-- Your existing mapping
			vim.keymap.set("n", "<leader>gs", function()
				vim.cmd.Git({
					mods = { vertical = true },
				})
			end)

			-- Helper function to navigate quickfix without nuking NvimTree
			local function diff_nav(direction, branch)
				-- 1. Find and close ONLY the Fugitive windows in the current tab
				for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
					local buf = vim.api.nvim_win_get_buf(win)
					local bufname = vim.api.nvim_buf_get_name(buf)

					if bufname:match("^fugitive://") then
						pcall(vim.api.nvim_win_close, win, false)
					end
				end

				-- 2. Turn off diff mode for the current file so it goes back to normal
				vim.cmd("diffoff!")

				-- 3. Move to the next/prev file in the quickfix list safely
				local cmd = direction == "next" and "cnext" or "cprev"
				local success, _ = pcall(function()
					vim.cmd(cmd)
				end)

				if not success then
					vim.notify("Reached end of quickfix list", vim.log.levels.WARN)
					return
				end

				-- 4. Open the new diff against the target branch
				vim.cmd("Gvdiffsplit " .. branch)
			end

			-- Dynamic diff review command
			vim.api.nvim_create_user_command("ReviewBranch", function(opts)
				local branch = opts.args

				-- 1. Populate quickfix list with changed files
				vim.cmd("Git difftool " .. branch)

				-- 2. Automatically jump to the first file and open the diff
				local has_diffs = pcall(function()
					vim.cmd("cfirst")
				end)

				if has_diffs then
					-- Trigger the split for the first file
					vim.cmd("Gvdiffsplit " .. branch)

					-- 3. Map ]q and [q to use our smart navigation function
					vim.keymap.set("n", "]q", function()
						diff_nav("next", branch)
					end, { desc = "Next Fugitive diff split (" .. branch .. ")" })

					vim.keymap.set("n", "[q", function()
						diff_nav("prev", branch)
					end, { desc = "Prev Fugitive diff split (" .. branch .. ")" })

					vim.notify(
						"Diff review started for: " .. branch .. "\nUse ]q and [q to navigate.",
						vim.log.levels.INFO
					)
				else
					vim.notify("No differences found against " .. branch, vim.log.levels.WARN)
				end
			end, {
				nargs = 1,
				desc = "Start Fugitive diff review against a specific branch",
			})
		end,
	},
}
