local keymap = vim.keymap.set -- Shorten function name
local opts = { silent = true }

-- Toggle comment
keymap('n', '<C-_>', 'gcc', opts)
keymap('i', '<C-_>', '<C-o>gcc', opts)
keymap('v', '<C-_>', 'gcc', opts)
