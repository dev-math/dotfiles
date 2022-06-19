-- general
vim.log.level = "warn"
-- vim.o.background = 'light'
lvim.colorscheme = "dracula"
lvim.format_on_save = false
lvim.line_wrap_cursor_movement = false

-- Vim options
vim.opt.linebreak = true -- break lines
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.wrap = true -- display lines as one long line
vim.opt.backup = false -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.encoding = "utf-8" -- the encoding displayed
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showtabline = 2 -- always show tabs
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set numbered lines
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.cursorline = false -- highlight the current line
vim.opt.smartcase = true -- case insentive unless capitals used in search
vim.opt.wildmenu = true -- on TAB, complete options for system command
vim.opt.directory = '~/.config/nvim/swap//,/tmp//'
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
vim.opt.whichwrap:remove({ 'h', 'l' })

vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.title = true -- set the title of window to the value of the titlestring
-- vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- file currentline/totallines - nvim
vim.opt.titlestring = "%<%F%= - nvim" -- file - nvim
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.numberwidth = 4 -- set number column width
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8

-- Plugins
lvim.plugins = {
  { "mustache/vim-mustache-handlebars" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "windwp/nvim-ts-autotag" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/cmp-emoji" },
  { "hrsh7th/cmp-nvim-lua" },
  {
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
  },
  { "moll/vim-bbye" },
  { "mg979/vim-visual-multi" },
  { "dracula/vim", as = "dracula" },
  { "nekonako/xresources-nvim" },
  { "AlphaTechnolog/pywal.nvim", as = "pywal" },
  { "norcalli/nvim-colorizer.lua" },
  { "mfussenegger/nvim-jdtls" },
}

-- lualine (statusline)
local components = require "lvim.core.lualine.components"

lvim.builtin.lualine.options = {
  icons_enabled = true,
  theme = 'auto',
  component_separators = { left = '', right = '' },
  section_separators = { left = '', right = '' },
  disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
  always_divide_middle = true,
}

lvim.builtin.lualine.sections = {
  lualine_a = { components.mode },
  lualine_b = { 'branch', components.diff },
  lualine_c = { 'filename', components.python_env },
  lualine_x = { components.diagnostics, components.treesitter, components.lsp, components.encoding, 'fileformat',
    'filetype' },
  lualine_y = { 'progress' },
  lualine_z = { 'location' },
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- lvim.builtin.which_key.active = false
-- local cmp = require 'cmp'
-- lvim.builtin.cmp.mapping['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }) -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
lvim.builtin.alpha.active = false
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.git.ignore = false
lvim.builtin.nvimtree.setup.filters.exclude = { "node_modules" }
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

local kind_icons = {
	 Text = "",
   Method = "",
   Function = "",
   Constructor = "",
   Field = "ﰠ",
   Variable = "",
   Class = "ﴯ",
   Interface = "",
   Module = "",
   Property = "ﰠ",
   Unit = "塞",
   Value = "",
   Enum = "",
   Keyword = "",
   Snippet = "",
   Color = "",
   File = "",
   Reference = "",
   Folder = "",
   EnumMember = "",
   Constant = "",
   Struct = "פּ",
   Event = "",
   Operator = "",
   TypeParameter = "",
}

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
  return
else
	luasnip.config.set_config {
		history = true,
		updateevents = "TextChanged,TextChangedI",
	}

	require("luasnip/loaders/from_vscode").lazy_load()
end

local cmp = require "cmp"
lvim.builtin.cmp = {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)

      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        buffer = "[BUF]",
      })[entry.source.name]

      return vim_item
    end,
  },
   mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ["<Tab>"] = function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
         else
            fallback()
         end
      end,
      ["<S-Tab>"] = function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
         else
            fallback()
         end
      end,
   },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    -- { name = "cmp_tabnine" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}

lvim.builtin.treesitter = {
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
    "vim",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  autotag = { enable = true },
  matchup = { enable = true },
}

require "colorizer".setup({ "*" }, {
  RGB = true, -- #RGB hex codes
  RRGGBB = true, -- #RRGGBB hex codes
  RRGGBBAA = true, -- #RRGGBBAA hex codes
  rgb_fn = true, -- CSS rgb() and rgba() functions
  hsl_fn = true, -- CSS hsl() and hsla() functions
  css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
  css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
})

require("indent_blankline").setup {
  indentLine_enabled = 1,
  char = "▏",
  filetype_exclude = {
    "help",
    "alpha",
    "terminal",
    "dashboard",
    "packer",
    "lspinfo",
    "TelescopePrompt",
    "TelescopeResults",
    "nvchad_cheatsheet",
  },
  buftype_exclude = { "terminal" },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
}

-- LSP
lvim.lsp.on_attach_callback = function(_, bufnr)
  vim.cmd [[
    command! Format execute 'lua vim.lsp.buf.formatting()'
  ]]
end

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { exe = "prettierd", filetypes = { "css" } },
  { exe = "isort", filetypes = { "python" } },
}

require("lspconfig")["emmet_ls"].setup({
  -- capabilities = capabilities,
  filetypes = { "html", "css", "typescriptreact", "javascriptreact" },
})

require("lspconfig")["html"].setup({
  filetypes = { "html" },
})

-- autocmds
vim.api.nvim_create_autocmd({ "TextChanged,TextChangedI" }, { pattern = "~/Notes/*.md", command = "silent write" })

-- keymappings
lvim.leader = "space"

-- Save file (Ctrl+S)
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["<C-s>"] = "<C-o>:w<cr>"
lvim.keys.visual_mode["<C-s>"] = "<Esc>:w<cr>"

-- Add selection to next find match (leaderkey + s)
vim.cmd [[
  let g:VM_maps = {}
  let g:VM_maps['Find Under']         = '<leader>s'
  let g:VM_maps['Find Subword Under'] = '<leader>s'
]]

--  Format document
lvim.keys.normal_mode["<leader>i>"] = ":Format<cr>"

--  Toggle comment
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { silent = true })
vim.api.nvim_set_keymap('i', '<C-_>', '<C-o>gcc', { silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', 'gcc', { silent = true })

--  Toggle file explorer
lvim.keys.normal_mode["<C-b>"] = ":NvimTreeToggle<cr>"
lvim.keys.insert_mode["<C-b>"] = "<Esc>:NvimTreeToggle<cr>"
lvim.keys.visual_mode["<C-b>"] = "<Esc>:NvimTreeToggle<cr>"

-- Copy line down (CTRL+SHIFT+D)
lvim.keys.normal_mode["<C-d>"] = ":t.<cr>"
lvim.keys.insert_mode["<C-d>"] = "<C-o>:t.<cr>"
lvim.keys.visual_mode["<C-d>"] = "<Esc>:'<,'>t.<CR>"

-- Control buffers
lvim.keys.normal_mode["<C-w>"] = ":Bd<cr>"
lvim.keys.normal_mode["<S-w>"] = ":Bd!<cr>"
lvim.keys.normal_mode["<Tab>"] = ":BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = ":BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<C-PageUp>"] = ":BufferLineCycleNext<cr>"
lvim.keys.normal_mode["<C-PageDown>"] = ":BufferLineCyclePrev<cr>"
lvim.keys.normal_mode["<S-PageUp>"] = ":BufferLineMovePrev<cr>"
lvim.keys.normal_mode["<S-PageDown>"] = ":BufferLineMoveNext<cr>"
lvim.keys.normal_mode["<leader>bp"] = ":BufferLinePick<cr>"
lvim.keys.normal_mode["<leader>1"] = ":BufferLineGoToBuffer 1<cr>"
lvim.keys.normal_mode["<leader>2"] = ":BufferLineGoToBuffer 2<cr>"
lvim.keys.normal_mode["<leader>3"] = ":BufferLineGoToBuffer 3<cr>"
lvim.keys.normal_mode["<leader>4"] = ":BufferLineGoToBuffer 4<cr>"
lvim.keys.normal_mode["<leader>5"] = ":BufferLineGoToBuffer 5<cr>"
lvim.keys.normal_mode["<leader>6"] = ":BufferLineGoToBuffer 6<cr>"
lvim.keys.normal_mode["<leader>7"] = ":BufferLineGoToBuffer 7<cr>"
lvim.keys.normal_mode["<leader>8"] = ":BufferLineGoToBuffer 8<cr>"
lvim.keys.normal_mode["<leader>9"] = ":BufferLineGoToBuffer 9<cr>"

-- use ESC to turn off search highlighting
lvim.keys.normal_mode["<Esc>"] = ":noh <cr>"

-- Search (Ctrl-f)
lvim.keys.normal_mode["<C-f>"] = "/"
-- Search text selected (/)
vim.cmd [[
vnoremap / y/\V<C-R>=escape(@",'/\')<CR><CR>
]]

-- Cut line (CTRL+X)
-- lvim.keys.normal_mode["<C-x>"] = "dd<cr>"
-- lvim.keys.insert_mode["<C-x>"] = "<C-o>dd<cr>"
-- lvim.keys.visual_mode["<C-x>"] = "<Esc>dd<cr>"
-- Remove line (dd)
lvim.keys.normal_mode["d"] = '"_d'
lvim.keys.visual_mode["d"] = '"_d'
-- Remove char (x)
lvim.keys.normal_mode["x"] = '"_x'
lvim.keys.visual_mode["x"] = '"_x'
