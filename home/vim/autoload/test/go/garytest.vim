if !exists('g:test#go#garytest#file_pattern')
  let g:test#go#garytest#file_pattern = '\v[^_].*_test\.go$'
endif

function! test#go#garytest#test_file(file) abort
  return test#go#test_file('garytest', g:test#go#garytest#file_pattern, a:file)
endfunction

function! test#go#garytest#build_position(type, position) abort
  if a:type ==# 'suite'
    return ['./...']
  else
    let path = './'.fnamemodify(a:position['file'], ':h')

    if a:type ==# 'file'
      return path ==# './.' ? [] : [path . '/...']
    elseif a:type ==# 'nearest'
      let name = s:nearest_test(a:position)
      return empty(name) ? [] : ['-run '.shellescape(name.'$', 1), path]
    endif
  endif
endfunction

function! test#go#garytest#build_args(args) abort
  if index(a:args, './...') >= 0
    return a:args
  endif
  let tags = []
  let index = 1
  let pattern = '^//\s*+build\s\+\(.\+\)'
  while index <= getbufinfo('%')[0]['linecount']
    let line = trim(getbufline('%', l:index)[0])
    if l:line =~# '^package '
      break
    endif
    let tag = substitute(line, l:pattern, '\1', '')
    if l:tag != l:line
      " replace OR tags with AND, since we are going to use all the tags anyway
      let tag = substitute(l:tag, ' \+', ',', 'g')
      call add(l:tags, l:tag)
    endif
    let index += 1
  endwhile
  if len(l:tags) == 0
    return a:args + ["2>&1 | tee /tmp/gotest.log | gotestfmt"]
  else
    let args = ['-tags=' . join(l:tags, ',')] + a:args
    return l:args + ["2>&1 | tee /tmp/gotest.log | gotestfmt"]
  endif
endfunction

function! test#go#garytest#executable() abort
  return 'go test -json'
endfunction

function! s:nearest_test(position) abort
  let name = test#base#nearest_test(a:position, g:test#go#patterns)
  let name = join(name['namespace'] + name['test'], '/')
  let without_spaces = substitute(name, '\s', '_', 'g')
  let escaped_regex = substitute(without_spaces, '\([\[\].*+?|$^()]\)', '\\\1', 'g')
  return escaped_regex
endfunction
