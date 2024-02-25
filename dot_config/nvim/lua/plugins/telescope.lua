-- Fuzzy Finder (files, lsp, etc)
return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Fuzzy Finder Algorithm which requires local dependencies to be built.
		-- Only load if `make` is available. Make sure you have the system
		-- requirements installed.
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		-- Enable telescope fzf native, if installed
		local builtin = require("telescope.builtin")
		pcall(require("telescope").load_extension, "fzf")

		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<C-p>", builtin.git_files, {})
		vim.keymap.set("n", "<leader>ps", builtin.live_grep)
		vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
	end,
}
