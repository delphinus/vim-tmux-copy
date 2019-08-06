let s:job_id = 0
let s:err = ''

function tmux_copy#call() abort
  if s:job_id != 0
    echoerr '[tmux-copy] running another instance. try again.'
    return
  endif
  if $TMUX ==# ''
    echoerr '[tmux-copy] not in tmux session'
    return
  endif
  let content = getreg(v:register, 1, v:true)
  let tmp = tempname()
  call writefile(content, tmp, 'b')
  let cmd = printf('bash -c ''cat "%s" | tmux load-buffer - && cat "%s" | pbcopy''', tmp, tmp)
  let s:job_id = jobstart(['bash', '-c', cmd], {
        \ 'on_stderr': 'tmux_copy#on_event',
        \ 'on_exit': 'tmux_copy#on_event',
        \ })
endfunction

function tmux_copy#on_event(job_id, data, event) abort
  if a:event ==# 'stderr'
    let s:err = '[tmux-copy]' . join(a:data, ' ')
  elseif a:event ==# 'exit'
    if a:data == 0
      echo '[tmux-copy] successfully copied!'
    elseif s:err !=# ''
      echoerr s:err
    endif
    let s:job_id = 0
    let s:err = ''
  endif
endfunction
