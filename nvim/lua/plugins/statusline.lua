return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local extensions = { "neo-tree", "lazy", "quickfix", "trouble", "nvim-dap-ui", "mason", "man" }
		local filetypes = { "DiffviewFiles" }
		for _, ft in ipairs(filetypes) do
			table.insert(extensions, {
				sections = { lualine_a = { {
					function()
						return ft
					end,
				} } },
				filetypes = { ft },
			})
		end
		require("lualine").setup({
			options = {
				icons_enabled = true,
				theme = "catppuccin-macchiato",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						separator = { left = "", right = "" },
					},
				},
				lualine_b = { { "branch", draw_empty = true }, "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { { "location", separator = { right = "", left = "" } } },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = extensions,
		})
	end,
}
-- vim: ts=2 sts=2 sw=2 et
