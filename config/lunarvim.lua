-- general
vim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "dracula"

-- local handle = io.popen([[pgrep -x picom > /dev/null && echo -n "1" || echo -n "0"]])
-- local picomResult = handle:read("*a")
-- handle:close()
-- if picomResult == "1" then
--   lvim.transparent_window = true
-- else
--   lvim.transparent_window = false
-- end

-- Vim options
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.wrap = true -- display lines as one long line
vim.wo.linebreak = true -- break lines
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
vim.opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
vim.opt.number = true -- set numbered lines
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.o.directory = '~/.config/nvim/swap//,/tmp//'
vim.opt.cursorline = false -- highlight the current line

vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.smartcase = true -- smart case
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.relativenumber = false -- set relative numbered lines
vim.opt.numberwidth = 4 -- set number column width to 2 {default 4}
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  { "BufEnter", "*", "set fo-=c fo-=r fo-=o" }, -- Stop newline continution of comments
}

-- Plugins
lvim.plugins = {
  {"moll/vim-bbye"},
  {"mg979/vim-visual-multi"},
  {"Mofiqul/dracula.nvim"},
  {"nekonako/xresources-nvim"},
}

-- lualine (statusline)
local components = require "lvim.core.lualine.components"

lvim.builtin.lualine.options = {
  icons_enabled = true,
  theme = 'auto',
  component_separators = { left = '', right = ''},
  section_separators = { left = '', right = ''},
  disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "toggleterm" },
  always_divide_middle = true,
}

lvim.builtin.lualine.sections = {
  lualine_a = {components.mode},
  lualine_b = {'branch', components.diff},
  lualine_c = {'filename', components.python_env},
  lualine_x = {components.diagnostics, components.treesitter, components.lsp, components.encoding, 'fileformat', 'filetype'},
  lualine_y = {'progress'},
  lualine_z = {'location'},
}

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = false
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

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

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

-- Save file (Ctrl+S)
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.insert_mode["<C-s>"] = "<C-o>:w<cr>"
lvim.keys.visual_mode["<C-s>"] = "<Esc>:w<cr>"

-- Add selection to next find match (Ctrl + d)
vim.cmd [[
  let g:VM_maps = {}
  let g:VM_maps['Find Under']         = '<C-d>'
  let g:VM_maps['Find Subword Under'] = '<C-d>'
]]

--  Format document
lvim.keys.normal_mode["<C-S-i>"] = ":Format<cr>"
lvim.keys.insert_mode["<C-S-i>"] = "<C-o>:Format<cr>"
lvim.keys.visual_mode["<C-S-i>"] = "<Esc>:Format<cr>"

--  Toggle comment
vim.api.nvim_set_keymap('n', '<C-_>', 'gcc', { silent = true })
vim.api.nvim_set_keymap('i', '<C-_>', '<C-o>gcc', { silent = true })
vim.api.nvim_set_keymap('v', '<C-_>', 'gcc', { silent = true })

--  Toggle file explorer
lvim.keys.normal_mode["<C-b>"] = ":NvimTreeToggle<cr>"
lvim.keys.insert_mode["<C-b>"] = "<Esc>:NvimTreeToggle<cr>"
lvim.keys.visual_mode["<C-b>"] = "<Esc>:NvimTreeToggle<cr>"

-- Copy line down (CTRL+SHIFT+D)
lvim.keys.normal_mode["<C-S-d>"] = ":t.<cr>"
lvim.keys.insert_mode["<C-S-d>"] = "<C-o>:t.<cr>"
lvim.keys.visual_mode["<C-S-d>"] = "<Esc>:'<,'>t.<CR>"

-- Control buffers
lvim.keys.normal_mode["<C-w>"] = ":Bd<cr>"
lvim.keys.normal_mode["<S-w>"] = ":Bd!<cr>"
lvim.keys.normal_mode["<Tab>"] = ":bnext<cr>"
lvim.keys.normal_mode["<S-Tab>"] = ":bprevious<cr>"
lvim.keys.normal_mode["<C-PageUp>"] = ":bnext<cr>"
lvim.keys.normal_mode["<C-PageDown>"] = ":bprevious<cr>"
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
lvim.keys.normal_mode["<C-x>"] = "dd<cr>"
lvim.keys.insert_mode["<C-x>"] = "<C-o>dd<cr>"
lvim.keys.visual_mode["<C-x>"] = "<Esc>dd<cr>"
-- Remove line (dd)
lvim.keys.normal_mode["d"] = '"_d'
lvim.keys.visual_mode["d"] = '"_d'
-- Remove char (x)
lvim.keys.normal_mode["x"] = '"_x'
lvim.keys.visual_mode["x"] = '"_x'
