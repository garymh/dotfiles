c() { cd ~/code/$1;  }

_c() { _files -W ~/code -/; }
compdef _c c

h() { cd ~/$1;  }

_h() { _files -W ~/ -/; }
compdef _h h

p() { cd ~/Library/Preferences/$1;  }

_p() { _files -W ~/ -/; }
compdef _p p
