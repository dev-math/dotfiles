require("nvim-treesitter.configs").setup({
	ignore_install = {
		"haskell",
	},
	ensure_installed = {
		"bash",
		"c",
		"comment",
		"cpp",
		"css",
		"glimmer",
		"go",
		"html",
		"java",
		"javascript",
		"jsdoc",
		"json",
		"jsonc",
		"markdown",
		"org",
		"lua",
		"php",
		"python",
		"query",
		"rst",
		"rust",
		"scss",
		"svelte",
		"tsx",
		"typescript",
		"tsx",
		"vim",
		"vimdoc",
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = { "org" },
		use_languagetree = true,
	},
	autotag = { enable = true },
	matchup = { enable = true },
	indent = { enable = true },
	refactor = {
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = false,
		},
	},
})
