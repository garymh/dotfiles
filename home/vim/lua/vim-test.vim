function! PrettyCommand(cmd) abort
  let clear = 'cls'
  let echo  = 'Echo '.shellescape(a:cmd)
  let separator = ' & '

  if !get(g:, 'test#preserve_screen')
    return join([l:clear, l:echo, a:cmd], l:separator)
  else
    return join([l:echo, a:cmd], l:separator)
  endif
endfunction

function! ExecuteScript(name, cmd) abort
  let script_path = expand("$DOTFILES") .. "/home/vim/lua/" .. a:name
  let cmd = join([shellescape(script_path), shellescape(a:cmd)])
  execute 'silent !'.cmd
endfunction

function! GaryTerminal(cmd) abort
  let cmd = join(['cd ' . shellescape(getcwd()), PrettyCommand(a:cmd)], '; ')
  call ExecuteScript('gary_terminal', cmd)
endfunction

let g:test#custom_strategies = {'gary_terminal': function('GaryTerminal')}
