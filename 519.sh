#! /bin/bash

if [ $# -ne 1 ]; then
 echo "" > &2
   exit  1
fi

check4_cmd_in_path "$1"
case $? in
   0) echo "exit cmd in path" ;;
   1) echo "can not found out cmd in path, which remains in doubt." ;;
   2) echo "cmd not exit in path" ;;
esac

exit 0
