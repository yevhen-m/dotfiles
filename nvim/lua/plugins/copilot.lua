return {
	"github/copilot.vim",
	event = "VeryLazy",
	init = function()
		vim.g.copilot_no_tab_map = true
		vim.keymap.set("i", "<M-/>", 'copilot#Accept("")', { expr = true, replace_keycodes = false })
	end,
}
