case "$1" in
  *_EDITMSG|*MERGE_MSG|*_TAGMSG )
    vim "$1"
    ;;
  * )
    $ACTUAL_EDITOR "$1"
    ;;
esac
