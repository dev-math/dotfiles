local ok, coq_nvim = pcall(require, "coq")
if not ok then
  return
end

vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
    -- recommended = false,
    bigger_preview = '',
    jump_to_mark = '',
  },
}

require('coq')
vim.cmd('COQnow --shut-up')
