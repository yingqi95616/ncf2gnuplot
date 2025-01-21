#!/bin/bash
for day in 134 135 136 137 138 139 140
do
for spec in NO2_UGM3 SO2_UGM3 # C5H8 HCHO O3 CO # SESQ # AALK ABNZ AXYL ATOL AOLGA AOLGB ASESQ ATRP1 AISOP SOA
do 
for ihr in 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23
do
cat << EOF | ./ncf2gnuplot.exe
${spec}
2010${day} ${ihr}0000
1 1
/data3/n065/qying/d/extract/out.cmaqclpf.fullchem.conc
/data3/n065/qying/d/extract/convert_to_calpuff/${spec}.${day}.${ihr}.fullchem.txt
EOF
done
done
done

