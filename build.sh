#!/bin/bash

# Check if there are three arguments
if [ $# -eq 3 ]; then
    # Check if the input files actually exist 
    if ! [[ -f "src/$1.tex" ]]; then 
       echo "The input file $1.tex does not exist."
       exit 1
    fi

    if ! [[ -f "src/$2.tex" ]]; then 
       echo "The input file $2.tex does not exist." 
       exit 1 
    fi 
else
   echo "Usage: $0 [input tex] [intput tex] [output]"
   exit 1
fi
  
# Creates the merged PDF
cd src;

pdflatex --shell-escape $1;
lualatex $2;

mv $1.pdf ../;
mv $2.pdf ../;

cd ../;

gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=$3.pdf -dBATCH $1.pdf $2.pdf;
