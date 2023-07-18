vim.keymap.set("n", "<leader>b", vim.cmd.Ex)

-- Cut line (CTRL+X)
vim.keymap.set("n", "<C-x>", "dd")
vim.keymap.set("i", "<C-x>", "<C-o>dd")
vim.keymap.set("v", "<C-x>", '"+x')

-- Remove line (dd)
vim.keymap.set({ "n", "v" }, "d", '"_d')
-- Remove char (x)
vim.keymap.set({ "n", "v" }, "x", '"_x')

-- use ESC to turn off search highlighting
vim.keymap.set("n", "<Esc>", ":noh <cr>")

-- move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor on place when using J
vim.keymap.set("n", "J", "mzJ`z")

-- half page jumping centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- rename
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- 'Find' centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })


-- Resize with arrows
vim.keymap.set('n', '<leader>k>', ':resize -2<CR>')
vim.keymap.set('n', '<leader>j', ':resize +2<CR>')
vim.keymap.set('n', '<leader>h', ':vertical resize -2<CR>')
vim.keymap.set('n', '<leader>l', ':vertical resize +2<CR>')
