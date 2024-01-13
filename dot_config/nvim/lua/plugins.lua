local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then
	return
end

lazy.setup({
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	"gpanders/editorconfig.nvim", -- EditorConfig plugin for neovim
	"mbbill/undotree",
	"jamespeapen/Nvim-R",

	{ "numToStr/Comment.nvim", opts = {} },

	-- Fuzzy Finder (files, lsp, etc)
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
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
	},

	-- colorscheme
	{
		"Tsuzat/NeoSolarized.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
	},

	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"JoosepAlviste/nvim-ts-context-commentstring",
			"andymass/vim-matchup",
			"windwp/nvim-ts-autotag",
		},
		build = ":TSUpdate",
	},

	{
		"lewis6991/gitsigns.nvim",
		opts = { current_line_blame = true },
	},

	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {},
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("cmp")
		end,
		dependencies = {
			"L3MON4D3/LuaSnip", -- Required
			"rafamadriz/friendly-snippets", -- Set of preconfigured snippets
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"andersevenrud/cmp-tmux",
		},
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			{ "jayp0521/mason-null-ls.nvim" },
		},
	},

	-- Autocompletion
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- lua snip
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			-- Set of preconfigured snippets
			"rafamadriz/friendly-snippets",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lua",
		},
	},

	-- Formatter and linter
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			{ "jayp0521/mason-null-ls.nvim" },
		},
	},

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},

	{
		"cbochs/grapple.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	-- org mode on vim
	{
		"nvim-orgmode/orgmode",
		dependencies = {
			{ "nvim-treesitter/nvim-treesitter", lazy = true },
		},
		event = "VeryLazy",
	},
})
