#! /usr/bin/bash
files_to_backup=`cat fileslist.txt`
for file in $files_to_backup
do
  echo $file
done

