" @wincent smart undo/backup settings
" probably not a great idea to mess with this.
if exists('$SUDO_USER')
  set nobackup                         " don't create root-owned files
  set nowritebackup                    " don't create root-owned files
  set noswapfile                       " don't create root-owned files
else
  if !has('nvim')
    silent !mkdir ~/.vim/tmp/backup > /dev/null 2>&1
    silent !mkdir ~/.vim/tmp/swap > /dev/null 2>&1
    set backupdir=~/.vim/tmp/backup//  " keep backup files out of the way
    set directory=~/.vim/tmp/swap//    " keep swap files out of the way
  endif
endif

if has('persistent_undo')
  set undofile                         " actually use undo files
  if exists('$SUDO_USER')
    set noundofile                     " don't create root-owned files
  else
    if !has('nvim')
      silent !mkdir ~/.vim/tmp/undo > /dev/null 2>&1
      set undodir=~/.vim/tmp/undo//      " keep undo files out of the way
    endif
  endif
endif

if has('viminfo')
  if exists('$SUDO_USER')
    set viminfo=                       " don't create root-owned files
  else
    if isdirectory('~/local/.vim/tmp')
      set viminfo+=n~/local/.vim/tmp/viminfo
    else
      set viminfo+=n~/.vim/tmp/viminfo " override ~/.viminfo default
    endif
    if !empty(glob('~/.vim/tmp/viminfo'))
      if !filereadable(expand('~/.vim/tmp/viminfo'))
        echoerr 'warning: ~/.vim/tmp/viminfo exists but is not readable'
      endif
    endif
  endif
endif
