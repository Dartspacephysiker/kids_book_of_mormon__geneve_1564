weekno=24

# pdfpref=OUT/ICBoM__20__May_18-24__Mosiah_25-28;

if [[ ${weekno} -eq 24 ]]
then
    startpage=125;
    stoppage=146;
    pdfpref=OUT/ICBoM__24__June_8-14__Alma_8-12;
elif [[ ${weekno} -eq 23 ]]
then
    startpage=112;
    stoppage=125;
    pdfpref=OUT/ICBoM__23__June_1-7__Alma_5-7;
elif [[ ${weekno} -eq 22 ]]
then
    startpage=91;
    stoppage=112;
    pdfpref=OUT/ICBoM__22__May_25-31__Mosiah_29-Alma_4;
elif [[ ${weekno} -eq 21 ]]
then
     startpage=78;
     stoppage=91;
     pdfpref=OUT/ICBoM__21__May_18-24__Mosiah_25-28;
elif [[ ${weekno} -eq 20 ]]
then
    startpage=56;
    stoppage=77;
    pdfpref=OUT/ICBoM__20__May_11-17__Mosiah_18-24;
elif [[ ${weekno} -eq 19 ]]
then
    startpage=37;
    stoppage=56;
    pdfpref=OUT/ICBoM__19__May_4-10__Mosiah_11-17;
elif [[ ${weekno} -eq 18 ]]
then
    startpage=25;
    stoppage=37;
    pdfpref=OUT/ICBoM__18__April_27-May_3__Mosiah_7-10;
else
    echo "No week selected!"
    exit
fi

licensefile=cclicense.pdf
bomfile=kids_bom.pdf

echo "Chunking out pages ${startpage} to ${stoppage} ..."
pdfseparate -f ${startpage} -l ${stoppage} ${bomfile} ${pdfpref}__%03d.pdf;

echo "Making ${pdfpref}.pdf ..."
pdfunite ${pdfpref}__*.pdf ${licensefile} ${pdfpref}.pdf

echo "Removing temporary files ..."
rm ${pdfpref}__*.pdf

echo DONE
