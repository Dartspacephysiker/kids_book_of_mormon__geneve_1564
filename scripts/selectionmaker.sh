weekno=39

licensefile=../cclicense.pdf
bomfile=../kids_bom.pdf
pdfoutdir=../OUT

if [[ ${weekno} -eq 39 ]]
then
    startpage=432;
    stoppage=446;
    pdfpref=${pdfoutdir}/ICBoM__39__Sep_21-27__3_Nephi_12-16;
elif [[ ${weekno} -eq 38 ]]
then
    startpage=421;
    stoppage=432;
    pdfpref=${pdfoutdir}/ICBoM__38__Sep_14-20__3_Nephi_8-11;
elif [[ ${weekno} -eq 37 ]]
then
    startpage=398;
    stoppage=421;
    pdfpref=${pdfoutdir}/ICBoM__37__Sep_7-13__3_Nephi_1-7;
elif [[ ${weekno} -eq 36 ]]
then
    startpage=383;
    stoppage=397;
    pdfpref=${pdfoutdir}/ICBoM__36__Aug_31-Sep_6__Helaman_13-16;
elif [[ ${weekno} -eq 35 ]]
then
    startpage=364;
    stoppage=383;
    pdfpref=${pdfoutdir}/ICBoM__35__Aug_24-30__Helaman_7-12;
elif [[ ${weekno} -eq 34 ]]
then
    startpage=339;
    stoppage=364;
    pdfpref=${pdfoutdir}/ICBoM__34__Aug_17-23__Helaman_1-6;
elif [[ ${weekno} -eq 33 ]]
then
    startpage=299;
    stoppage=338;
    pdfpref=${pdfoutdir}/ICBoM__33__Aug_10-16__Alma_53-63;
elif [[ ${weekno} -eq 32 ]]
then
    startpage=256;
    stoppage=299;
    pdfpref=${pdfoutdir}/ICBoM__32__Aug_3-9__Alma_43-52;
elif [[ ${weekno} -eq 31 ]]
then
    startpage=244;
    stoppage=256;
    pdfpref=${pdfoutdir}/ICBoM__31__July_27-Aug_2__Alma_39-42;
elif [[ ${weekno} -eq 30 ]]
then
    startpage=233;
    stoppage=244;
    pdfpref=${pdfoutdir}/ICBoM__30__July_20-26__Alma_36-38;
elif [[ ${weekno} -eq 29 ]]
then
    startpage=218;
    stoppage=233;
    pdfpref=${pdfoutdir}/ICBoM__29__July_13-19__Alma_32-35;
elif [[ ${weekno} -eq 28 ]]
then
    startpage=207;
    stoppage=218;
    pdfpref=${pdfoutdir}/ICBoM__28__July_6-12__Alma_30-31;
elif [[ ${weekno} -eq 27 ]]
then
    startpage=186;
    stoppage=207;
    pdfpref=${pdfoutdir}/ICBoM__27__June_29-July_5__Alma_23-29;
elif [[ ${weekno} -eq 26 ]]
then
    startpage=160;
    stoppage=186;
    pdfpref=${pdfoutdir}/ICBoM__26__June_22-28__Alma_17-22;
elif [[ ${weekno} -eq 25 ]]
then
    startpage=146;
    stoppage=160;
    pdfpref=${pdfoutdir}/ICBoM__25__June_15-21__Alma_13-16;
elif [[ ${weekno} -eq 24 ]]
then
    startpage=125;
    stoppage=146;
    pdfpref=${pdfoutdir}/ICBoM__24__June_8-14__Alma_8-12;
elif [[ ${weekno} -eq 23 ]]
then
    startpage=112;
    stoppage=125;
    pdfpref=${pdfoutdir}/ICBoM__23__June_1-7__Alma_5-7;
elif [[ ${weekno} -eq 22 ]]
then
    startpage=91;
    stoppage=112;
    pdfpref=${pdfoutdir}/ICBoM__22__May_25-31__Mosiah_29-Alma_4;
elif [[ ${weekno} -eq 21 ]]
then
     startpage=78;
     stoppage=91;
     pdfpref=${pdfoutdir}/ICBoM__21__May_18-24__Mosiah_25-28;
elif [[ ${weekno} -eq 20 ]]
then
    startpage=56;
    stoppage=77;
    pdfpref=${pdfoutdir}/ICBoM__20__May_11-17__Mosiah_18-24;
elif [[ ${weekno} -eq 19 ]]
then
    startpage=37;
    stoppage=56;
    pdfpref=${pdfoutdir}/ICBoM__19__May_4-10__Mosiah_11-17;
elif [[ ${weekno} -eq 18 ]]
then
    startpage=25;
    stoppage=37;
    pdfpref=${pdfoutdir}/ICBoM__18__April_27-May_3__Mosiah_7-10;
else
    echo "No week selected!"
    exit
fi

echo "Chunking out pages ${startpage} to ${stoppage} ..."
pdfseparate -f ${startpage} -l ${stoppage} ${bomfile} ${pdfpref}__%03d.pdf;

echo "Making ${pdfpref}.pdf ..."
pdfunite ${pdfpref}__*.pdf ${licensefile} ${pdfpref}.pdf

echo "Removing temporary files ..."
rm ${pdfpref}__*.pdf

echo DONE
