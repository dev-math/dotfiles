-- Add selection to next find match (leaderkey + s)
vim.cmd [[
  let g:VM_maps = {}
  let g:VM_maps['Find Under']         = '<leader>s'
  let g:VM_maps['Find Subword Under'] = '<leader>s'
]]
