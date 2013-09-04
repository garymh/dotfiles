new_gemset() {
  rvm gemset create $1
  rvm gemset use $1
  rvm gemset list
}

gac() {
    hub add --all :/
    hub commit -m "$*"
}

nudais_release() {
  echo "git flow release start \"v$1\""
  echo "git flow release finish \"v$1\" -m \"v$1\""
}

gitclone() {
    cd ~/code/
    git clone "$*"
}

search() {
    echo "find . -iname \"*$1*\""
    sudo find . -iname "*$1*"
}

bug(){
  ghi open --message "$*" --claim --label SpaceAllocation bug
 }

new_issue(){
  ghi open --message "$*" --claim --label SpaceAllocation
}

zopen(){
  open `a $*`
}

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

# batch change extension
chgext() {
  for file in *.$1 ; do mv $file `echo $file | sed "s/\(.*\.\)$1/\1$2/"` ; done
}

if [[ $IS_MAC -eq 1 ]]; then
  gclo() {
      cd ~/code/
      git clone "$*"
  }

  vm() {
      cd ~/code/vagrant-ubuntu-oracle-xe
      vagrant up
      cd ~/code/nudais/rails
  }

  vmoff() {
      cd ~/code/vagrant-ubuntu-oracle-xe
      vagrant suspend
  }

  fix_stupid_homebrew_cask() {
    ls -l /usr/local/Library/Formula | grep phinze-cask | awk '{print $9}' | for evil_symlink in $(cat -); do rm -fv /usr/local/Library/Formula/$evil_symlink; done
  }

fi

# alias last and save
# use `als c NAME` to chop off the last argument (for filenames/patterns)
als() {
  local aliasfile chop x
  [[ $# == 0 ]] && echo "Name your alias" && return
  if [[ $1 == "c" ]]; then
    chop=true
    shift
  fi
  aliasfile=~/.zsh/recorded_aliases.zsh
  touch $aliasfile
  if [[ `cat "$aliasfile" |grep "alias ${1// /}="` != "" ]]; then
    echo "Alias ${1// /} already exists"
  else
    x=`fc -l -n -1`
    if [[ $chop == true ]]; then
      echo "Chopping..."
      x=$(echo $x | rev | cut -d " " -f2- | rev)
    fi
    echo -e "\nalias ${1// /}=\"`echo $x|sed -e 's/ *$//'|sed -e 's/\"/\\\\"/g'`\"" >> $aliasfile && source $aliasfile
    alias $1
  fi
}

# -------------------------------------------------------------------
# any function from http://onethingwell.org/post/14669173541/any
# search for running processes
# -------------------------------------------------------------------
any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}

# -------------------------------------------------------------------
# display a neatly formatted path
# -------------------------------------------------------------------
path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

# -------------------------------------------------------------------
# compressed file expander
# (from https://github.com/myfreeweb/zshuery/blob/master/zshuery.sh)
# -------------------------------------------------------------------
ex() {
    if [[ -f $1 ]]; then
        case $1 in
          *.tar.bz2) tar xvjf $1;;
          *.tar.gz) tar xvzf $1;;
          *.tar.xz) tar xvJf $1;;
          *.tar.lzma) tar --lzma xvf $1;;
          *.bz2) bunzip $1;;
          *.rar) unrar $1;;
          *.gz) gunzip $1;;
          *.tar) tar xvf $1;;
          *.tbz2) tar xvjf $1;;
          *.tgz) tar xvzf $1;;
          *.zip) unzip $1;;
          *.Z) uncompress $1;;
          *.7z) 7z x $1;;
          *.dmg) hdiutul mount $1;; # mount OS X disk images
          *) red "'$1' cannot be extracted via >ex<";;
    esac
    else
        red "'$1' is not a valid file"
    fi
}
