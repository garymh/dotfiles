whats_my_path() {
    echo $PATH | tr ":" "\n" | sort
}

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

# batch change extension
chgext() {
  for file in *.$1 ; do mv $file `echo $file | sed "s/\(.*\.\)$1/\1$2/"` ; done
}

fix_stupid_homebrew_cask() {
  ls -l /usr/local/Library/Formula | grep phinze-cask | awk '{print $9}' | for evil_symlink in $(cat -); do rm -fv /usr/local/Library/Formula/$evil_symlink; done
}

gac() {
    hub add --all :/
    hub commit -m "$*"
}

gclo() {
    cd ~/code/
    git clone "$*"
}

vm() {
    cd ~/code/vagrant-ubuntu-oracle-xe
    vagrant up
    vagrant ssh
}

vmoff() {
    cd ~/code/vagrant-ubuntu-oracle-xe
    vagrant suspend
}

gitclone() {
    cd ~/code/
    git clone "$*"
}

testing() {
    cd ~/code/nudais/rails
    bundle exec guard -c
}

search() {
    echo "find . -iname \"*$1*\""
    sudo find . -iname "*$1*"
}

new_issue(){
  ghi open --message "$*" --claim --label SpaceAllocation
 }

issues(){
  ghi list --state open --mine
}
alias my_issues='issues'

# Remote Mount (sshfs)
# creates mount folder and mounts the remote filesystem
rmount() {
  local host folder mname
  host="${1%%:*}:"
  [[ ${1%:} == ${host%%:*} ]] && folder='' || folder=${1##*:}
  if [[ -n $2 ]] ; then
    mname=$2
  else
    mname=${folder##*/}
    [[ "$mname" == "" ]] && mname=${host%%:*}
  fi
  if [[ $(grep -i "host ${host%%:*}" ~/.ssh/config) != '' ]]; then
    mkdir -p ~/Remote/$mname > /dev/null
    sshfs $host$folder ~/Remote/$mname -oauto_cache,reconnect,defer_permissions,negative_vncache,volname=$mname,noappledouble && echo "mounted ~/Remote/$mname"
  else
    echo "No entry found for ${host%%:*}"
    return 1
  fi
}

# Remote Umount, unmounts and deletes local folder (experimental, watch you step)
rumount() {
  if [[ $1 == "-a" ]] ; then
    ls -1 ~/Remote/|while read dir
    do
      [[ -d $(mount|grep "mounts/$dir") ]] && umount ~/Remote/$dir
      [[ -d $(ls ~/Remote/$dir) ]] || rm -rf ~/Remote/$dir
    done
  else
    [[ -d $(mount|grep "mounts/$1") ]] && umount ~/Remote/$1
    [[ -d $(ls ~/Remote/$1) ]] || rm -rf ~/Remote/$1
  fi
}