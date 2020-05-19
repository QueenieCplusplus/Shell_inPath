# Shell_inPath

Common Usage:

     * cd to directory
  
     * touch < file_name > to create file
     
     * open -e < file_name > to edit file
     
     * .. < file_name > to reload file

Script 1

    #! /bin/bash
    # inpath-- path 路徑指向有效的程式，而非僅僅系統預設的程式


	in_path()
	{	
	 # once valid return 0, otherwise return  1. 

	  cmd=$1 path=$2 result=1
	  ifs=$IFS IFS=":"

	  for dir in '$path'
          do
           if [ -x $dir/$cmd] ; then
             result=0 # valid means this program find out the cmd in path
           fi
	  done
	  IFS=$ifs
          return $result
	}

        check4_cmd_in_path()
	{
	 var=$1
	 if [ "$var" != ""] ; then
	    if [ "${var:0:1}" = "/" ] ; then  # (a)
		if [ ! -x $var ] ; then  # (b)
		  return 1
	        fi
	    elif ! in_path $var "PATH" ; then
		return 2
            fi
         fi
        }

Syntax

(a) 變數切割法 ${var:0:1} 

判斷第一字元是否為 /

此為從字串中取得子字串的一種簡寫方法，並且從指定的位移值開始取得指定長度的字元，如未指定限制長度，即回傳位移值後的所有字元。

(b) -x Bash 運算子

檢查此路徑是否存在。

Script 2

	#! /bin/bash

	if [ $# -n 1]; then
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

(to be continued...)
