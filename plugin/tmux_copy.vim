if exists('g:loaded_tmux_copy')
  finish
endif
let g:loaded_tmux_copy = 1

if !has('nvim')
  echoerr '[tmux-copy] this is for Neovim only'
  finish
endif

let s:save_cpo = &cpoptions
set cpoptions&vim

nnoremap <silent> <Plug>TmuxCopy :call tmux_copy#call()<CR>

if get(g:, 'tmux_copy_map', 1)
  map <A-[> <Plug>TmuxCopy
endif

let &cpoptions = s:save_cpo
unlet s:save_cpo
