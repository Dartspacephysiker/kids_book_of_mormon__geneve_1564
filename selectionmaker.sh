startpage=37;
stoppage=56;
pdfpref=OUT/ICBoM__19__May_4-10__Mosiah_11-17;

# startpage=25;
# stoppage=37;
# pdfpref=OUT/ICBoM__18__April_27-May_3__Mosiah_7-10;

licensefile=cclicense.pdf
bomfile=kids_bom.pdf

echo "Chunking out pages ${startpage} to ${stoppage} ..."
pdfseparate -f ${startpage} -l ${stoppage} ${bomfile} ${pdfpref}__%03d.pdf;

echo "Making ${pdfpref}.pdf ..."
pdfunite ${pdfpref}__*.pdf ${licensefile} ${pdfpref}.pdf

echo "Removing temporary files ..."
rm ${pdfpref}__*.pdf

echo DONE
