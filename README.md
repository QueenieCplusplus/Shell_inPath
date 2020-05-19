# Shell_inPath

Common Usage:

     * cd to directory
  
     * touch < file_name > to create file
     
     * open -e < file_name > to edit file
     
     * .. < file_name > to reload file

Script

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
	    if [ "${var:0:1}" = "/" ] ; then
		if [ ! -x $var ] ; then
		  return 1
	        fi
	    elif ! in_path $var "PATH" ; then
		return 2
            fi
         fi
        }
