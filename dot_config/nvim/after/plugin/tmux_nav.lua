-- Don't allow any default key-mappings.
vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set('n', '<C-h>', ':TmuxNavigateLeft<cr>')
vim.keymap.set('n', '<C-j>', ':TmuxNavigateDown<cr>')
vim.keymap.set('n', '<C-k>', ':TmuxNavigateUp<cr>')
vim.keymap.set('n', '<C-l>', ':TmuxNavigateRight<cr>')
