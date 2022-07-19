local keymap = vim.keymap.set -- Shorten function name
local opts = { silent = true }

-- Don't allow any default key-mappings.
vim.g.tmux_navigator_no_mappings = 1

-- Re-enable tmux_navigator.vim default bindings, minus <c-\>. <c-\> conflicts with NERDTree "current file".
keymap('n', '<C-h>', ':TmuxNavigateLeft<cr>', opts)
keymap('n', '<C-j>', ':TmuxNavigateDown<cr>', opts)
keymap('n', '<C-k>', ':TmuxNavigateUp<cr>', opts)
keymap('n', '<C-l>', ':TmuxNavigateRight<cr>', opts)
