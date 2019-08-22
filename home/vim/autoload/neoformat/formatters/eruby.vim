function! neoformat#formatters#eruby#enabled() abort
  return ['prettydiff']
endfunction

function! neoformat#formatters#eruby#htmlbeautify() abort
  return {
        \ 'exe': 'html-beautify',
        \ 'args': ['--indent-size ' .shiftwidth()],
        \ 'stdin': 1,
        \ }
endfunction

function! neoformat#formatters#eruby#prettydiff() abort
  return {
        \ 'exe': 'prettydiff',
        \ 'args': ['beautify',
        \ 'lang:"erb"',
        \ 'insize:' .shiftwidth(),
        \ 'readmethod:"filescreen"',
        \ 'endquietly:"quiet"',
        \ 'source:"%:p"'],
        \ 'no_append': 1
        \ }
endfunction
