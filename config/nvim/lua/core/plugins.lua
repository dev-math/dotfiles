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

package.loaded["core.config"] = false
local config = require("core.config")

return require("lazy").setup({
  'antoinemadec/FixCursorHold.nvim', -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  'rafamadriz/friendly-snippets',    -- Set of preconfigured snippets
  'gpanders/editorconfig.nvim',      -- EditorConfig plugin for neovim
  'lervag/vimtex',                   -- Latex support

  -- Using coc (my old config)
  {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
      require("coc")
    end,
    enabled = not config.enable_lsp,
  },
  -- Better Syntax Support
  { "sheerun/vim-polyglot", enabled = not config.enable_lsp },
  -- Auto pairs
  { "jiangmiao/auto-pairs", enabled = not config.enable_lsp },

  -- LSP
  {
    "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      -- { 'j-hui/fidget.nvim' }, -- lsp progress
      { "b0o/SchemaStore.nvim" },               -- Access to the SchemaStore catalog
      {
        "jose-elias-alvarez/nvim-lsp-ts-utils", -- Improve TS development
        ft = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
          { "jayp0521/mason-null-ls.nvim" },
        },
        config = function()
          require("plugins.null_ls")
        end,
      },
      {
        "ray-x/lsp_signature.nvim",
        config = function()
          require("lsp.lsp-signature")
        end,
        enabled = config.enable_lsp_signature,
      },
    },
    enabled = config.enable_lsp,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("plugins.treesitter")
    end,
    enabled = config.enable_lsp,
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  {
    "preservim/vim-markdown",
    dependencies = {
      {
        "godlygeek/tabular",
      },
    },
    enabled = false,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("plugins.autopairs")
    end,
    event = "InsertEnter",
  },

  {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "hrsh7th/nvim-cmp", -- Autocompletion
    config = function()
      require("plugins.nvim-cmp")
    end,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require("plugins.luasnip")
        end,
      },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "andersevenrud/cmp-tmux",
    },
    event = 'InsertEnter',
    enabled = config.enable_lsp,
  },

  {
    "ms-jpq/coq_nvim",
    branch = "coq", -- Fast as FUCK nvim completion
    config = function()
      require("plugins.coq")
    end,
    dependencies = {
      { "ms-jpq/coq.artifacts",  branch = "artifacts" },
      { "ms-jpq/coq.thirdparty", branch = "3p" },
    },
    enabled = false,
  },

  {
    "folke/todo-comments.nvim", -- Highlight, list and search todo comments in your projects
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.todo-comments")
    end,
  },

  {
    "akinsho/toggleterm.nvim", -- Easily manage multiple terminal windows
    version = "v2.*",
    config = function()
      require("plugins.toggleterm")
    end,
  },

  {
    "mg979/vim-visual-multi",
    config = function()
      require("plugins.vim-visual-multi")
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer")
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent-blankline")
    end,
  },

  {
    "rcarriga/nvim-notify", -- Beautiful notifications
    config = function()
      require("plugins.notify")
    end,
    dependencies = { "nvim-telescope/telescope.nvim" },
  },

  {
    "nvim-telescope/telescope.nvim",
    version = "0.1.0", -- fuzzy finder
    config = function()
      require("plugins.telescope")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-lua/popup.nvim" },
    },
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    dependencies = "nvim-telescope/telescope.nvim",
  },

  {
    "kosayoda/nvim-lightbulb", -- Lightbulbs on lines with code actions
    config = function()
      require("nvim-lightbulb").setup({ autocmd = { enabled = true } })
    end,
    enabled = config.enable_lightbulb,
  },

  {
    "christoomey/vim-tmux-navigator",
    config = function() -- navigation between tmux panes and vim splits
      require("plugins.tmux-nav")
    end,
  },

  {
    "numToStr/Comment.nvim", -- Smart and Powerful commenting plugin for neovim
    config = function()
      require("plugins.comment")
    end,
    event = "BufWinEnter",
  },

  {
    "moll/vim-bbye", -- Delete buffers without closing windows or messing up your layout
    config = function()
      require("plugins.vim-bbye")
    end,
    event = "BufWinEnter",
  },

  {
    "kyazdani42/nvim-tree.lua", -- File Explorer
    config = function()
      require("plugins.nvim-tree")
    end,
    cmd = {
      "NvimTreeClipboard",
      "NvimTreeClose",
      "NvimTreeFindFile",
      "NvimTreeOpen",
      "NvimTreeRefresh",
      "NvimTreeToggle",
    },
    event = "VimEnter",
  },
  { "nvim-tree/nvim-web-devicons", lazy = true },
  {
    "nvim-lualine/lualine.nvim", -- Statusline
    config = function()
      require("plugins.lualine")
    end,
    after = "nvim-lspconfig",
  },

  {
    "akinsho/bufferline.nvim", -- Tabline
    version = "v3.*",
    config = function()
      require("plugins.bufferline")
    end,
  },

  -- Java Support
  {
    "mfussenegger/nvim-jdtls",
  },

  {
    "artur-shaik/jc.nvim",
    enabled = false,
  },

  -- Colorschemes
  {
    -- 'dracula/vim',
    "Mofiqul/dracula.nvim",
    name = "dracula",
    config = function()
      vim.cmd("colorscheme dracula")
    end,
    enabled = config.theme == "dracula",
  },
  {
    "AlphaTechnolog/pywal.nvim",
    name = "pywal",
    config = function()
      vim.cmd("colorscheme pywal")
    end,
    enabled = config.theme == "pywal",
  },
  {
    "sainnhe/gruvbox-material",
    config = function()
      vim.cmd("colorscheme gruvbox-material")
    end,
    enabled = config.theme == "gruvbox-material",
  },
  {
    "nekonako/xresources-nvim",
    config = function()
      vim.cmd("colorscheme xresources-nvim")
    end,
    enabled = config.theme == "xresources-nvim",
  },
  {
    "Mofiqul/vscode.nvim",
    config = function()
      vim.cmd("colorscheme vscode")
    end,
    enabled = config.theme == "vscode",
  },

  {
    "ishan9299/nvim-solarized-lua",
    config = function()
      vim.cmd("colorscheme solarized")
    end,
    enabled = config.theme == "solarized",
  },
})
