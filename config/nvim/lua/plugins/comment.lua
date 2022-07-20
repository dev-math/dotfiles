local ok, comment = pcall(require, "Comment")
if not ok then
  return
end

comment.setup()

local keymap = vim.api.nvim_set_keymap -- Shorten function name
local opts = { silent = true }

-- Toggle comment
keymap('n', '<C-_>', 'gcc', opts)
keymap('i', '<C-_>', '<C-o>gcc', opts)
keymap('v', '<C-_>', 'gcc', opts)
