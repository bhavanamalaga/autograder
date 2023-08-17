#!/bin/bash

mkdir organised

cd organised

cd - > /dev/null

cd mock_grading

for i in $( cat roll_list );
	do
	len=$(expr length "$i")
	mkdir ../organised/$i > /dev/null
done

let "len= $len + 1" 

cd submissions


for FILE in *; 
	do
	pathe=$( echo "$FILE" | cut --complement -c$len- )
	cd ../../
	ln -s ../../mock_grading/submissions/$FILE organised/$pathe/$FILE
	cd mock_grading/submissions;
done
