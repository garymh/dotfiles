
" Handles gem 'formula' to open its homepage.

const s:pattern = 'gem\s\+[''"]\([a-zA-Z0-9_.-]\+\)[''"]'

function! gxext#ruby#gemfile#open(line, mode)
  let l:line = a:line
  if a:mode ==# 'normal'
    let l:line = getline('.')
    let l:col = col('.') - 1
    let l:line = gxext#matchstr_around(l:line, s:pattern, l:col)
  endif

  let l:match = matchlist(l:line, s:pattern)
  if empty(l:match)
    return 0
  endif

  let l:plugin_name = l:match[1]
  silent !clear
  execute "!open $(gem info " . l:match[1] . " | grep \"Homepage\" | grep -Eo \"(http|https)://[a-zA-Z0-9./?=_%:-]*\")"

  return 1
endfunction
