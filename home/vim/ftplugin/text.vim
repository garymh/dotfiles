" set spell
set wrap
set linebreak
if v:version > 800
  set breakindent
endif

setlocal formatoptions+=tcoqnl1j

setlocal formatlistpat=^\\s*[\\[({]\\\?\\([0-9]\\+\\\|[iIvVxXlLcCdDmM]\\+\\\|[a-zA-Z]\\)[\\]:.)}]\\s\\+\\\|^\\s*[-+o*]\\s\\+
