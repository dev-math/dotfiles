-- Install packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

package.loaded['core.config'] = false
local config = require('core.config')

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself as an optional plugin
  use 'lewis6991/impatient.nvim' -- Speed up loading Lua modules
  use 'nathom/filetype.nvim' -- A faster version of filetype.vim 
  use 'antoinemadec/FixCursorHold.nvim' -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open
  use 'rafamadriz/friendly-snippets' -- Set of preconfigured snippets
  use 'gpanders/editorconfig.nvim' -- EditorConfig plugin for neovim
  use 'lervag/vimtex' -- Latex support

  -- Using coc (my old config)
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      require('coc')
    end,
    disable = config.enable_lsp
  }
  -- Better Syntax Support
  use { 'sheerun/vim-polyglot', disable = config.enable_lsp }
  -- Auto pairs
  use { 'jiangmiao/auto-pairs', disable = config.enable_lsp }

  -- LSP
  use {
    'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
    requires = {
      { 'williamboman/nvim-lsp-installer' }, -- Automatically install language servers to stdpath
      { 'j-hui/fidget.nvim' }, -- lsp progress
      { 'b0o/SchemaStore.nvim' }, -- Access to the SchemaStore catalog
      {
        'jose-elias-alvarez/nvim-lsp-ts-utils', -- Improve TS development
        ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
      },
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          require('plugins.null_ls')
        end,
        after = 'nvim-lspconfig',
      },
      {
        'ray-x/lsp_signature.nvim',
        config = function()
          require('lsp.lsp-signature')
        end,
        after = 'nvim-lspconfig',
        disable = not config.enable_lsp_signature,
      },
    },
    disable = not config.enable_lsp
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-refactor',
    },
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    config = function()
      require('plugins.treesitter')
    end,
    disable = not config.enable_lsp
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('plugins.autopairs')
    end,
    event = 'InsertEnter',
  }

  use {
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup()
    end
  }

  use {
    'hrsh7th/nvim-cmp', -- Autocompletion
    config = function()
      require('plugins.nvim-cmp')
    end,
    requires = {
      {
        'L3MON4D3/LuaSnip',
        config = function()
          require('plugins.luasnip')
        end,
      },
      { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      -- { 'hrsh7th/cmp-tabnine'}, after = 'nvim-cmp' },
      { 'andersevenrud/cmp-tmux', after = 'nvim-cmp' },
    },
    -- event = 'InsertEnter',
    disable = not config.enable_lsp
  }

  use {
    'ms-jpq/coq_nvim', branch = 'coq', -- Fast as FUCK nvim completion
    config = function()
      require('plugins.coq')
    end,
    requires = {
      { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
      { 'ms-jpq/coq.thirdparty', branch = '3p' },
    },
    disable = true
  }

  use {
    'folke/todo-comments.nvim', -- Highlight, list and search todo comments in your projects
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('plugins.todo-comments')
    end
  }

  use {
    'akinsho/toggleterm.nvim', -- Easily manage multiple terminal windows
    tag = 'v2.*',
    config = function()
      require('plugins.toggleterm')
    end
  }

  use {
    'mg979/vim-visual-multi',
    config = function()
      require('plugins.vim-visual-multi')
    end
  }

  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('plugins.colorizer')
    end,
  }

  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('plugins.indent-blankline')
    end,
  }

  use {
    'rcarriga/nvim-notify', -- Beautiful notifications
    config = function()
      require('plugins.notify')
    end,
    requires = { 'nvim-telescope/telescope.nvim' },
  }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0', -- fuzzy finder
    config = function()
      require('plugins.telescope')
    end,
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-lua/popup.nvim' },
    }
  }

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
    requires = 'nvim-telescope/telescope.nvim'
  }

  use {
    'kosayoda/nvim-lightbulb', -- Lightbulbs on lines with code actions
    config = function()
      require('nvim-lightbulb').setup({ autocmd = { enabled = true } })
    end,
    disable = not config.enable_lightbulb,
  }

  use {
    'christoomey/vim-tmux-navigator',
    config = function() -- navigation between tmux panes and vim splits
      require('plugins.tmux-nav')
    end
  }

  use {
    'numToStr/Comment.nvim', -- Smart and Powerful commenting plugin for neovim
    config = function()
      require('plugins.comment')
    end,
    event = 'BufWinEnter',
  }

  use {
    'moll/vim-bbye', -- Delete buffers without closing windows or messing up your layout
    config = function()
      require('plugins.vim-bbye')
    end,
    event = 'BufWinEnter'
  }

  use {
    'kyazdani42/nvim-tree.lua', -- File Explorer
    config = function()
      require('plugins.nvim-tree')
    end,
    requires = {
      'kyazdani42/nvim-web-devicons', -- For file icons
      opt = true
    },
    cmd = {
      'NvimTreeClipboard',
      'NvimTreeClose',
      'NvimTreeFindFile',
      'NvimTreeOpen',
      'NvimTreeRefresh',
      'NvimTreeToggle',
    },
    event = 'VimEnter',
  }

  use {
    'nvim-lualine/lualine.nvim', -- Statusline
    config = function()
      require('plugins.lualine')
    end,
    requires = {
      'kyazdani42/nvim-web-devicons', -- For file icons
      opt = true
    },
    after = 'nvim-lspconfig',
  }

  use {
    'akinsho/bufferline.nvim', -- Tabline
    tag = 'v2.*',
    config = function()
      require('plugins.bufferline')
    end,
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- Colorschemes
  use {
    'dracula/vim',
    as = 'dracula',
    config = function()
      vim.cmd('colorscheme dracula')
    end,
    disable = config.theme ~= 'dracula',
  }
  use {
    'AlphaTechnolog/pywal.nvim',
    as = 'pywal',
    config = function()
      vim.cmd('colorscheme pywal')
    end,
    disable = config.theme ~= 'pywal',
  }
  use {
    'sainnhe/gruvbox-material',
    config = function()
      vim.cmd('colorscheme gruvbox-material')
    end,
    disable = config.theme ~= 'gruvbox-material',
  }
  use {
    'nekonako/xresources-nvim',
    config = function()
      vim.cmd('colorscheme xresources-nvim')
    end,
    disable = config.theme ~= 'xresources-nvim',
  }


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
