local M = {}

local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Close popup menu on Esc
-- vim.cmd[[[ inoremap <expr><Esc> pumvisible() ? "\<C-e>" : "\<Esc>" ]]]
keymap('i', '<Esc>', 'pumvisible() ? "\\<C-e>" : "\\<Esc>"', { noremap = true, silent = true, expr = true })

-- Window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

keymap("i", "<C-h>", "<Esc><C-w>h", opts)
keymap("i", "<C-j>", "<Esc><C-w>j", opts)
keymap("i", "<C-k>", "<Esc><C-w>k", opts)
keymap("i", "<C-l>", "<Esc><C-w>l", opts)

keymap("v", "<C-h>", "<C-w>h", opts)
keymap("v", "<C-j>", "<C-w>j", opts)
keymap("v", "<C-k>", "<C-w>k", opts)
keymap("v", "<C-l>", "<C-w>l", opts)

--  Format document
keymap("n", "<C-S-i>", ":Format<CR>", opts)
keymap("v", "<C-S-i>", "<Esc>:Format<CR>", opts)
keymap("i", "<C-S-i>", "<Esc>:Format<CR>", opts)

-- Add selection to next find match (Ctrl + d)
vim.cmd [[
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Find Subword Under'] = '<C-d>'
]]

-- use ESC to turn off search highlighting
keymap("n", "<Esc>", ":noh <CR>", { silent = true } )

-- Toggle terminal
keymap("n", '<C-t>', ":ToggleTerm<CR>", opts)
keymap("i", '<C-t>', "<Esc>:ToggleTerm<CR>", opts)
keymap("v", '<C-t>', "<Esc>:ToggleTerm<CR>", opts)

-- Control buffers
keymap("n", "<C-w>", ":Bd<CR>", { silent = true } )
keymap("n", "<S-w>", ":Bd!<CR>", { silent = true } )
keymap("n", "<C-n>", ":enew<CR>", opts)
keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<C-PageUp>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<C-PageDown>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<S-PageUp>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<S-PageDown>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "bp", ":BufferLinePick<CR>", opts)
keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", opts)
keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", opts)
keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", opts)
keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", opts)
keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", opts)
keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", opts)
keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", opts)
keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", opts)
keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", opts)

-- Toggle comment
keymap("n", "<C-_>", "gcc", { silent = true } )
keymap("i", "<C-_>", "<Esc> gcc", { silent = true } )
keymap("v", "<C-_>", "gcc", { silent = true } )

-- Toggle file explorer --
keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
keymap("i", "<C-b>", "<Esc>:NvimTreeToggle<CR>", opts)
keymap("v", "<C-b>", "<Esc>:NvimTreeToggle<CR>", opts)

-- Search text selected (/)
vim.cmd [[
vnoremap / y/\V<C-R>=escape(@",'/\')<CR><CR>
]]

-- Search (Ctrl-f)
keymap("n", "<C-f>", "/", { silent = false } )
-- Search in all files (Shift-f)
keymap("n", "<S-f>", ":Telescope live_grep <CR>", opts)

-- Save file (Ctrl+S)
keymap("n", "<C-s>", ":w<CR>", opts)
keymap("i", "<C-s>", "<Esc>:w<CR>", opts)
keymap("v", "<C-s>", "<Esc>:w<CR>", opts)

-- Copy line down (CTRL+SHIFT+D)
keymap("n", "<C-S-d>", ":t.<CR>", opts)
keymap("i", "<C-S-d>", "<Esc>:t.<CR>", opts)
keymap("v", "<C-S-d>", "<Esc>:'<,'>t.<CR>", opts)
-- Move line down (ALT+J)
keymap("n", "<A-j>", ":m .+1<CR>", opts)
keymap("i", "<A-j>", "<Esc>:m .+1<CR>", opts)
keymap("v", "<A-j>", "<Esc>:m .+1<CR>", opts)
-- Move line up (ALT+K)
keymap("n", "<A-k>", ":m .-2<CR>", opts)
keymap("i", "<A-k>", "<Esc>:m .-2<CR>", opts)
keymap("v", "<A-k>", "<Esc>:m .-2<CR>", opts)
-- Cut line (CTRL+X)
keymap("n", "<C-x>", "dd<CR>", opts)
keymap("i", "<C-x>", "<Esc>dd<CR>", opts)
keymap("v", "<C-x>", "<Esc>dd<CR>", opts)
-- Remove line (dd)
keymap("n", "d", '"_d', opts)
keymap("v", "d", '"_d', opts)

M.lspconfig = function(bufnr)
	 -- See `:help vim.lsp.*` for documentation on any of the below functions
	vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  -- Renamer
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<F2>', '<cmd>lua require("renamer").rename()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<F2>', '<cmd>lua require("renamer").rename()<cr>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<F2>', '<cmd>lua require("renamer").rename()<cr>', opts)
end

return M
