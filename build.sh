#!/bin/bash
if [ $# -eq 0 ]
  then
  echo "Usage: [Cover Letter Title] [Cover file].tex"
  exit 1
fi

#################################
# Generates required PDF files
#################################
coverTemp="cover"
resumeTemp="resume"

# Dynamically preprocesses the cover letter to give it a specfic attrs off the cmd
cp src/cover-template.tex src/cover.tex
sed -i -e "s/REPLACE1/$1/g"     src/cover.tex     #title    - From the command line
sed -i -e "s/REPLACE2/$2.tex/g" src/cover.tex     #content  - From a file in cover-files/

cd src;
pdflatex --shell-escape $coverTemp  || { echo 'Cover generation failed' ; exit 1; }
lualatex $resumeTemp                || { echo 'Resume generation failed'; exit 1; }

#################################
# Merges the actual PDFs together
#################################

mv $coverTemp.pdf ../pdf/;
mv $resumeTemp.pdf ../pdf/;

cd ../pdf/;


coverName="$coverTemp.pdf"
resumeName="$resumeTemp.pdf"

# Used to generate the file name in the format : CoverTitle.14-01-2015.pdf
titleName=$(echo "$1" | tr -d ' ')
now="$(date +'%d-%m-%Y')"
mergeName="${titleName}.${now}.pdf"

# Status of the merge
echo "\n\n-------------------\nMerging\t -> $coverName \nWith\t -> $resumeName \nTo\t -> $mergeName\n-------------------\n\n "

# Actually merges the files
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=$mergeName -dBATCH $coverName $resumeName || { echo 'Merging failed'; exit 1; }
