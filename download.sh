#!/bin/bash

if [ $# -ne 2 ]
then
	echo Usage: bash download.sh \<link to directory\> \<cut-dirs argument\>
	exit 1 
fi

wget -q -r $1 -nH -np --cut-dirs=$2

for d in */ ; do
    if [ $d != mock_grading/ ]
    then
    	mv $d mock_grading/
    fi
done

cd mock_grading

rm index.html
