-- intelligently close a window
vim.cmd [[
function! CloseWindowOrKillBuffer(IGNORE_SAVE)
  let number_of_windows_to_this_buffer = len(filter(range(1, winnr('$')), "winbufnr(v:val) == bufnr('%')"))

  if matchstr(expand("%"), 'NERD') == 'NERD'
    wincmd c
    return
  endif

  if number_of_windows_to_this_buffer > 1
    wincmd c
  else
    if a:IGNORE_SAVE == 'true'
      Bd!
    else
      Bd 
    endif
  endif
endfunction

nnoremap <silent> <C-w> :call CloseWindowOrKillBuffer("false")<CR>
nnoremap <silent> <S-w> :call CloseWindowOrKillBuffer("true")<CR>
]]
