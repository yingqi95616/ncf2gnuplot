#!/bin/bash
for spec in PM10 # HT 
do
cat << EOF | ./ncf2gnuplot.exe
${spec}
2006061 000000
1 1
/home/qying/papers/mexico_dust/plots/emis/PM10_emis_nodust_episode_3km.ncf
/home/qying/papers/mexico_dust/plots/emis/pm10_emis_nodust.wrf3km.txt
EOF
done
