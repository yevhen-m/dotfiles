return {
	"nvim-pack/nvim-spectre",
	build = false,
	cmd = "Spectre",
	opts = { open_cmd = "noswapfile" },
  -- stylua: ignore
  keys = {
    { "<leader>sf", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
  },
}
