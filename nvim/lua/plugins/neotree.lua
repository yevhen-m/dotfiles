return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		opts = {},
		keys = {
			{ "-", "<cmd>Neotree reveal<cr>", desc = "Neotree" },
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
