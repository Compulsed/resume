cd src;

pdflatex --shell-escape $1;
lualatex $2;

mv $1.pdf ../;
mv $2.pdf ../;

cd ../;

gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=$3.pdf -dBATCH $1.pdf $2.pdf;
