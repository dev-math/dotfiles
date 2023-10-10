vim.g.mapleader = " "

vim.opt.guicursor = ""

vim.g.netrw_liststyle = 3 -- Now it will be a tree view
vim.g.netrw_bufsettings = "nu nobl"

vim.opt.smartindent = true -- make indenting smarter again
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.shiftwidth = 2     -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2        -- insert 2 spaces for a tab
vim.opt.softtabstop = 2    -- insert 2 spaces for a tab

-- ui
vim.opt.pumheight = 10                -- pop up menu height
vim.opt.number = true                 -- set numbered lines
vim.opt.relativenumber = true         -- set numbered lines relative to current line
vim.opt.cursorline = true             -- highlight the current line
vim.opt.wrap = true                   -- don't display lines as one long line
vim.opt.linebreak = true              -- break lines
vim.opt.showtabline = 2               -- always show tabs
vim.opt.splitbelow = true             -- force all horizontal splits to go below current window
vim.opt.splitright = true             -- force all vertical splits to go to the right of current window
vim.opt.termguicolors = true          -- set term gui colors (most terminals support this)
vim.opt.scrolloff = 8                 -- Minimal number of screen lines to keep above and below the cursor

-- backup
vim.opt.swapfile = false    -- creates a swapfile
vim.opt.backup = false      -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.undofile = true     -- enable persistent undo
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"

-- search
vim.opt.hlsearch = true   -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true  -- case insentive unless capitals used in search
vim.opt.wildmenu = true   -- on TAB, complete options for system command
vim.opt.wildignore = vim.opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*' }

-- performance
vim.opt.lazyredraw = true  -- screen will not be redrawn while executing macros, registers and other commands that have not been typed
vim.opt.redrawtime = 1500  -- time in milliseconds for redrawing the display
vim.opt.timeoutlen = 500   -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 10   -- time in milliseconds to wait for a key code sequence to complete
vim.opt.signcolumn = "yes"            -- always show the sign column otherwise it would shift the text each time
vim.opt.updatetime = 100   -- faster completion

vim.opt.colorcolumn = "80"

-- misc
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.cmd [[
  autocmd BufWinEnter * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd BufRead * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd BufNewFile * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
]]
vim.opt.hidden = true             -- required to keep multiple buffers and open multiple buffers
vim.opt.conceallevel = 0          -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"    -- the encoding written to a file
vim.opt.encoding = "utf-8"        -- the encoding displayed
