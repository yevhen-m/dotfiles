return {
	"stevearc/aerial.nvim",
	opts = {},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = {
		"Aerial",
		"AerialPrev",
		"AerialNext",
		"AerialToggle",
	},
	config = function()
		require("aerial").setup({
			autojump = true,
			resize_to_content = false,
			-- optionally use on_attach to set keymaps when aerial has attached to a buffer
			on_attach = function(bufnr)
				-- Jump forwards/backwards with '{' and '}'
				vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
				vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
			end,
		})
		-- You probably also want to set a keymap to toggle aerial
		vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle!<CR>", { desc = "[A]erial [T]oggle" })
	end,
}
