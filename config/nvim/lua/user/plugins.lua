local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "dracula/vim"
  use "dylanaraps/wal.vim"
	use "numToStr/Comment.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "kyazdani42/nvim-web-devicons"
	use "kyazdani42/nvim-tree.lua"
	use "akinsho/bufferline.nvim"
	use "nvim-lualine/lualine.nvim"
	use "akinsho/toggleterm.nvim"
	use "mg979/vim-visual-multi"
	use "editorconfig/editorconfig-vim"
	use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
	use {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  }

	-- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
	use "windwp/nvim-ts-autotag"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	-- LSP
	use "neovim/nvim-lspconfig" -- enable LSP
	use "williamboman/nvim-lsp-installer" -- simple to use language server installer
	use 'ray-x/lsp_signature.nvim'
	use "b0o/SchemaStore.nvim"
	-- use {
    -- "folke/trouble.nvim",
    -- cmd = "TroubleToggle",
  -- }
	use "filipdutescu/renamer.nvim"

	-- Snippets
	use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
	use 'L3MON4D3/LuaSnip' -- Snippets plugin

	-- Autocompletion
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"
	use {
    "tzachar/cmp-tabnine",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
      }
    end,

    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
  }

	use "norcalli/nvim-colorizer.lua"
	use "andymass/vim-matchup"
	use "windwp/nvim-autopairs"
	use "moll/vim-bbye"
	use "goolord/alpha-nvim"
	use "antoinemadec/FixCursorHold.nvim"
	-- use "ahmedkhalf/project.nvim"
	-- use "folke/which-key.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
