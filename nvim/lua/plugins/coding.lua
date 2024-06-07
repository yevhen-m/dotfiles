return {
	"thinca/vim-visualstar",
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"tpope/vim-rsi",
	"tpope/vim-surround",
  "vim-scripts/ReplaceWithRegister",
	{ "numToStr/Comment.nvim", opts = {} },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equalent to setup({}) function
	},
	{
		"ggandor/leap.nvim",
		dependencies = {
			"tpope/vim-repeat",
		},
		config = function()
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
			-- Override some old defaults - use backspace instead of tab (see issue #165).
			require("leap").opts.special_keys.prev_target = "<backspace>"
			require("leap").opts.special_keys.prev_group = "<backspace>"

			-- Use the traversal keys to repeat the previous motion without explicitly
			-- invoking Leap.
			require("leap.user").set_repeat_keys("s<enter>", "s<backspace>")
		end,
	},
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {
			mappings = {
				["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\`].", register = { cr = false } },
			},
		},
		keys = {
			{
				"<leader>up",
				function()
					vim.g.minipairs_disable = not vim.g.minipairs_disable
				end,
				desc = "Toggle Auto Pairs",
			},
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
