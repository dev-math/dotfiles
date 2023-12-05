vim.diagnostic.config({ virtual_text = true })

vim.opt.showmode = false
vim.opt.guicursor = ""
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8      -- Minimal number of screen lines to keep above and below the cursor

vim.opt.smartindent = true
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.shiftwidth = 4     -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4        -- insert 4 spaces for a tab
vim.opt.softtabstop = 4    -- insert 4 spaces for a tab

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"

vim.opt.lazyredraw = true  -- screen will not be redrawn while executing macros, registers and other commands that have not been typed
vim.opt.redrawtime = 1500  -- time in milliseconds for redrawing the display
vim.opt.timeoutlen = 500   -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 10   -- time in milliseconds to wait for a key code sequence to complete
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

vim.opt.hidden = true
vim.opt.conceallevel = 0 -- so that ``` is visible in MD files
