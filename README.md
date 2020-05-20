# Shell_inPath

* Common Usage:

     * cd to directory
  
     * touch < file_name > to create file
     
     * open -e < file_name > to edit file , alternative way is vim < file_name >
     
     * .. < file_name > to reload file
     
* Common Variable:

     * $n, such as $1, $2 means Arg1, Arg2 ... and so on.
     
     * $#, aggregate number of params passing thru script or function file.
     
     * $?, means return val or status from above function.

* Script 1

	    #! /bin/bash
	    # inpath-- path 路徑指向有效的程式，而非僅僅系統預設的程式


		in_path()
		{	
		 # once valid return 0, otherwise return  1. 

		  cmd=$1 path=$2 result=1
		  ifs=$IFS IFS=":"

		  for dir in '$path'
		  do
		   if [ -x $dir/$cmd ] ; then
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

* Syntax

   * (a) 變數切割法 ${var:0:1} 解決一個問題有很多方法，例如 $(echo $var | cut c1)

		    the actual grammar is : ${var:start:size} 變數切分方式

		    判斷第一字元是否為 /

	     此為從字串中取得子字串的一種簡寫方法，並且從指定的位移值開始取得指定長度的字元，如未指定限制長度，即回傳位移值後的所有字元。

  * (b) -x 運算子

        檢查此路徑是否存在。

* Script 2

		#! /bin/bash

		if [ $# -ne 1] ; then  # (d) # (f)
		 echo "" > &2
		   exit  1
		fi

		check4_cmd_in_path "$1"
		case $? in   # (c)
		   0) echo "exit cmd in path" ;;
		   1) echo "can not found out cmd in path, which remains in doubt." ;;
		   2) echo "cmd not exit in path" ;;
		esac

		exit 0
	
* Syntax

  * (c) 變數切割法 $? 

        此為正規表示法，即第一字元，如 -c1

  * (d) 變數切割方法 #

         用來刪除符合比對模板的第一組實體。

  * (e) 變數擷取方法 %

          符合比對模板的內容之後遺留下來的結果。
   
  * (f) -ne or -eq
  
	     -n means not equal

	     -eq means equal

* Execution Scripts

Before Execution, plz add absolute path in env var
and execute the shell script in this way...

	$ inpath echo
	echo 存在於路徑清單中

(to be continued...)

All related with DBMoonLab

![DBMoonLab](https://scontent.ftpe8-4.fna.fbcdn.net/v/t1.0-9/98203909_119976096373700_7204052016853680128_n.png?_nc_cat=102&_nc_sid=8024bb&_nc_ohc=Er7KIbqCSf4AX9Gc2Jd&_nc_ht=scontent.ftpe8-4.fna&oh=c74e21010fe975540a9ddb1981f002f1&oe=5EE8C2D0)
