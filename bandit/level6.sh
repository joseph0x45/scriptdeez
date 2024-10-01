# find the file that is human readable
# that has 1033 bytes of size and is not executable

find . -type f | while read -r f; do
  if file "$f" | grep -q "ASCII text"; then
    is_ascii=1;
  else
    is_ascii=0;
  fi
  if test -x "$f"; then
    is_exec=1;
  else
    is_exec=0;
  fi
  if [[ $(du -b "$f" | cut -f1) -eq 1033 ]];then
    is_1033_bytes=1;
  else
    is_1033_bytes=0;
  fi

  if [[ is_ascii -eq 1 && $is_1033_bytes -eq 1 && $is_exec -eq 0 ]]; then
    cat "$f"
  fi
done
