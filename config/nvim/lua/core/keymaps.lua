local keymap = vim.keymap.set -- Shorten function name
local opts = { noremap = true, silent = true }
-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- keyleader is set on core.init.lua

-- Window spliter
keymap('n', 'ss', '<C-w>s', opts)
keymap('n', 'vv', '<C-w>v', opts)

-- Quit insert mode
keymap('i', 'jk', '<Esc>', opts)
keymap('i', 'kj', '<Esc>', opts)
keymap('i', 'jj', '<Esc>', opts)

-- Save file
keymap('n', '<C-s>', ':w<CR>', opts)
keymap('i', '<C-s>', '<C-o>:w<CR>', opts)
keymap('v', '<C-s>', '<Esc>:w<CR>', opts)

-- use ESC to turn off search highlighting
keymap('n', '<Esc>', ':noh <cr>', opts)

-- Cut line (CTRL+X)
keymap('n', '<C-x>', 'dd', opts)
keymap('i', '<C-x>', '<C-o>dd', opts)
keymap('v', '<C-x>', '"+x', opts)

-- Remove line (dd)
keymap({'n', 'v'}, 'd', '"_d', opts)
-- Remove char (x)
keymap({ 'n', 'v' }, 'x', '"_x', opts)

-- Copy line down
keymap('n', '<C-d>', ':t.<CR>', opts)
keymap('i', '<C-d>', '<C-o>:t.<CR>', opts)
keymap('v', '<C-d>', "<Esc>:'<,'>t.<CR>", opts)

-- Move line down
keymap('n', '<A-j>', '<Esc>:m .+1<CR>==', opts)
keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
keymap('v', '<A-j>', ":m '>+1<CR>gv-gv", opts)

-- Move line up
keymap('n', '<A-k>', '<Esc>:m .-2<CR>==', opts)
keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv-gv", opts)

-- Search text selected (ctrl+f)
vim.cmd [[
vnoremap <C-f> y/\V<C-R>=escape(@",'/\')<CR><CR>
]]
keymap('n', '<C-f>', '', opts)

-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Window navigation
-- normal mode
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)
-- term mode
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', opts)

-- Indenting
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Quickfix mappings
keymap('n', '<leader>ck', ':cexpr []<cr>', opts)
keymap('n', '<leader>cc', ':cclose <cr>', opts)
keymap('n', '<leader>co', ':copen <cr>', opts)
keymap('n', '<leader>cf', ':cfdo %s/', opts)
keymap('n', '<leader>cp', ':cprev<cr>zz', opts)
keymap('n', '<leader>cn', ':cnext<cr>zz', opts)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)


-- LSP
keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
-- keymap("v", "<leader>ca", vim.lsp.buf.range_code_action, opts)

keymap("n", "gd", require("telescope.builtin").lsp_definitions, opts)
keymap("n", "gi", require("telescope.builtin").lsp_implementations, opts)
keymap("n", "gr", require("telescope.builtin").lsp_references, opts)
keymap("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, opts)
keymap("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, opts)

keymap("n", "K", vim.lsp.buf.hover, opts)
keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)

keymap("n", "gD", vim.lsp.buf.declaration, opts)
keymap("n", "gt", require("telescope.builtin").lsp_type_definitions, opts)
keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
keymap("n", "<leader>wl", function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, opts)
keymap("n", "<leader>i", vim.lsp.buf.format, opts)
-- keymap("v", "<leader>i", vim.lsp.buf.range_formatting, opts)

-- Create a command `:Format` local to the LSP buffer
vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, { desc = "Format current buffer with LSP" })
