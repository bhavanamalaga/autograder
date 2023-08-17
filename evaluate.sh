#!/bin/bash

cd organised

for d in */ ;
    do 
    cd $d
	for FILE in *;
		do
		if [ $FILE = *.cpp ]
		then
			g++ $FILE -o executable 2> /dev/null
		fi 
	done
	cd ..
done

for d in */;
	do
	cd $d
	mkdir student_outputs
	for FILE in ../../mock_grading/inputs/*;
		do
		num=$(basename $FILE .in)
		#num=$(basename $f .in)
		#echo $FILE
		timeout 5 ./executable < $FILE > student_outputs/$num.out 2> \/dev\/null | cat
	done
	cd ..
done

for d in */;
	do
	cd $d
	let "score= 0"
	for FILE in ../../mock_grading/outputs/*;
		do
		num=$(basename $FILE .out)
		if  cmp -s "$FILE" "student_outputs/$num.out" ; 
		then 
			let "score= $score + 1"
		fi
	done
	d=$(basename $d /)
	echo "$d,$score" >> ../../unsorted_marksheet.csv
	echo "$score" >> ../../unsorted_distribution.txt
	cd ..
done

cd ../

sort -r unsorted_distribution.txt > distribution.txt
rm unsorted_distribution.txt

sort -t"," -r -k2 unsorted_marksheet.csv > marksheet.csv
rm unsorted_marksheet.csv



		
