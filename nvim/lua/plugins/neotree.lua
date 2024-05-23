return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		cmd = { "Neotree" },
		keys = {
			{ "-", "<cmd>Neotree reveal<cr>", desc = "Neotree" },
		},
		init = function()
			vim.api.nvim_create_autocmd("BufEnter", {
				-- make a group to be able to delete it later
				group = vim.api.nvim_create_augroup("NeoTreeInit", { clear = true }),
				callback = function()
					local f = vim.fn.expand("%:p")
					if vim.fn.isdirectory(f) ~= 0 then
						vim.cmd("Neotree current dir=" .. f)
						-- neo-tree is loaded now, delete the init autocmd
						vim.api.nvim_clear_autocmds({ group = "NeoTreeInit" })
					end
				end,
			})
			-- keymaps
		end,
		config = function()
			require("neo-tree").setup({
				filesystem = {
					hijack_netrw_behavior = "open_current",
				},
				commands = {
					copy_selector = function(state)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						local filename = node.name
						local modify = vim.fn.fnamemodify

						local vals = {
							["BASENAME"] = modify(filename, ":r"),
							["EXTENSION"] = modify(filename, ":e"),
							["FILENAME"] = filename,
							["PATH (CWD)"] = modify(filepath, ":."),
							["PATH (HOME)"] = modify(filepath, ":~"),
							["PATH"] = filepath,
							["URI"] = vim.uri_from_fname(filepath),
						}

						local options = vim.tbl_filter(function(val)
							return vals[val] ~= ""
						end, vim.tbl_keys(vals))
						if vim.tbl_isempty(options) then
							vim.notify("No values to copy", vim.log.levels.WARN)
							return
						end
						table.sort(options)
						vim.ui.select(options, {
							prompt = "Choose to copy to clipboard:",
							format_item = function(item)
								return ("%s: %s"):format(item, vals[item])
							end,
						}, function(choice)
							local result = vals[choice]
							if result then
								vim.notify(("Copied: `%s`"):format(result))
								vim.fn.setreg("+", result)
							end
						end)
					end,
				},
				window = {
					mappings = {
						Y = "copy_selector",
					},
				},
			})
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
