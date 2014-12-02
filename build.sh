#!/bin/bash

if [ $# -eq 0 ]
  then
  echo "Usage: [Cover Letter Title] [Cover file].tex [Output Pdf].pdf"
  exit 1
fi


coverFile="cover"
resumeFile="resume"

cp src/cover-template.tex src/cover.tex
sed -i -e "s/REPLACE1/$1/g" src/cover.tex     #title
sed -i -e "s/REPLACE2/$2.tex/g" src/cover.tex #content


# Creates the merged PDF
cd src;

# Generates the cover letter
pdflatex --shell-escape $coverFile;

# Generates the resume itself
lualatex $resumeFile;

mv $coverFile.pdf ../pdf/;
mv $resumeFile.pdf ../pdf/;

cd ../;

# Merges the actual PDFs together
gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=pdf/$3.pdf -dBATCH pdf/$coverFile.pdf pdf/$resumeFile.pdf;
