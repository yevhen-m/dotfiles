return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	enabled = false,
	init = function()
		vim.cmd.colorscheme("tokyonight-night")
	end,
	opts = {
		style = "night",
		lualine_bold = true,
		styles = {
			-- Style to be applied to different syntax groups
			-- Value is any valid attr-list value for `:help nvim_set_hl`
			comments = { italic = true },
			keywords = { italic = true },
			functions = {},
			variables = {},
			-- Background styles. Can be "dark", "transparent" or "normal"
			sidebars = "dark", -- style for sidebars, see below
			floats = "dark", -- style for floating windows
		},
		on_highlights = function(hl, c)
			-- Don't show orange prompts in the Telescope window
			hl.TelescopePromptBorder = {
				fg = c.keywords,
			}
			hl.TelescopePromptTitle = {
				fg = c.keywords,
			}
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
