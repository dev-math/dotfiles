-- ========= Vim Options =========

vim.log.level = "warn"
-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
  if msg:match("exit code") then
    return
  end
  if log_level == vim.log.levels.ERROR then
    vim.api.nvim_err_writeln(msg)
  else
    vim.api.nvim_echo({ { msg } }, true, {})
  end
end

-- indentation
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab
-- vim.opt.colorcolumn = "99999"                                -- fixes indentline for now

-- search
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true -- case insentive unless capitals used in search
vim.opt.wildmenu = true -- on TAB, complete options for system command
vim.opt.wildignore = vim.opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*' }

-- autocomplete
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- Set completeopt to have a better completion experience
vim.opt.shortmess = vim.opt.shortmess + { c = true }

-- performance
vim.opt.lazyredraw = true -- screen will not be redrawn while executing macros, registers and other commands that have not been typed
vim.opt.redrawtime = 1500 -- time in milliseconds for redrawing the display
vim.opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 10 -- time in milliseconds to wait for a key code sequence to complete
vim.opt.updatetime = 100 -- faster completion
vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time

-- backup
vim.opt.swapfile = false -- creates a swapfile
vim.opt.backup = false -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited

-- misc
vim.opt.undofile = true -- enable persistent undo
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.directory = '~/.config/nvim/swap//,/tmp//'
vim.opt.formatoptions:remove({ 'c', 'r', 'o' }) -- dont take effect. using autocmd...
vim.opt.whichwrap:remove({ 'h', 'l' })
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.encoding = "utf-8" -- the encoding displayed

-- ui
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.cursorline = true -- highlight the current line
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set numbered lines relative to current line
vim.opt.wrap = true -- don't display lines as one long line
vim.opt.linebreak = true -- break lines
vim.opt.showtabline = 2 -- always show tabs
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%= - nvim" -- file - nvim
vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
vim.opt.numberwidth = 4 -- set number column width
vim.opt.scrolloff = 8 -- Minimal number of screen lines to keep above and below the cursor
vim.opt.sidescrolloff = 8 -- Minimal number of screen columns to keep to the left and to the right of the cursor
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages

-- DISABLE
local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',
  'getscript',
  'getscriptPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'logipat',
  'rrhelper',
  'spellfile_plugin',
  'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 0
end
