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

return require("lazy").setup({
  {
    "m4xshen/hardtime.nvim",
    opts = {}
  },
  "ThePrimeagen/vim-be-good",

  {
    "ms-jpq/coq_nvim",
    branch = "coq", -- Fast as FUCK nvim completion
    dependencies = {
      { "ms-jpq/coq.artifacts",  branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
    enabled = true,
  },

  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = "nvim-telescope/telescope.nvim",
  },

  -- navigation between tmux panes and vim splits
  "christoomey/vim-tmux-navigator",

  {
    "numToStr/Comment.nvim", -- Smart and Powerful commenting plugin for neovim
    event = "BufWinEnter",
    opts = {},
  },

  {
    "moll/vim-bbye", -- Delete buffers without closing windows or messing up your layout
    event = "BufWinEnter",
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },

  {
    'luisiacc/gruvbox-baby',
    branch = 'main',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.g.gruvbox_baby_keyword_style = "NONE"
      -- vim.g.gruvbox_baby_function_style = "NONE"
      vim.g.gruvbox_baby_transparent_mode = 1
      vim.cmd.colorscheme('gruvbox-baby')
    end,
    enabled = true,
  },

  "NvChad/nvim-colorizer.lua",

  -- Java Support
  {
    "mfussenegger/nvim-jdtls",
  },

  {
    'Mofiqul/vscode.nvim',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme('vscode')
    end,
    enabled = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "andymass/vim-matchup",
    },

    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        current_line_blame = false,
      })
    end
  },

  'mbbill/undotree',
  'gpanders/editorconfig.nvim', -- EditorConfig plugin for neovim

  {
    'VonHeikemen/lsp-zero.nvim',
    lazy = true,
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {                            -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      -- 'hrsh7th/nvim-cmp',     -- Required
      -- 'L3MON4D3/LuaSnip',     -- Required
      -- "saadparwaiz1/cmp_luasnip",
      -- 'hrsh7th/cmp-nvim-lsp', -- Required
      -- "hrsh7th/cmp-nvim-lua",
      -- "hrsh7th/cmp-buffer",
      -- "hrsh7th/cmp-path",
      -- 'rafamadriz/friendly-snippets', -- Set of preconfigured snippets
    }
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      { "jayp0521/mason-null-ls.nvim" },
    },
  },

  "lukas-reineke/indent-blankline.nvim",
})
