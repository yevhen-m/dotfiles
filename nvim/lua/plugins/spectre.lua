return {
	{
		"nvim-pack/nvim-spectre",
		build = false,
		cmd = "Spectre",
		opts = { open_cmd = "noswapfile" },
		keys = {
			{
				"<leader>sf",
				function()
					require("spectre").open()
				end,
				desc = "Replace in Files (Spectre)",
			},
		},
	},
}
-- vim: ts=2 sts=2 sw=2 et
