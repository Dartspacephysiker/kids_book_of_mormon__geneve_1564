startpage=25;
stoppage=37;
pdfpref=OUT/ICBoM__17__April_27-May_3__Mosiah_7-10;
licensefile=cclicense.pdf

pdfseparate -f ${startpage} -l ${stoppage} kids_bom.pdf ${pdfpref}__%03d.pdf;
pdfunite ${pdfpref}__*.pdf ${licensefile} ${pdfpref}.pdf

echo DONE
