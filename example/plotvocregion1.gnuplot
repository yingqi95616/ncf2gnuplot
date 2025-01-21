set terminal postscript portrait color enhanced 10 
set output "regional.ps"
set pm3d map
set palette rgbformulae 22,13,-31
set multiplot
unset xtics
unset ytics
#set format cb ""
#unset colorbox
set lmargin 0
set rmargin 0
set tmargin 0
set bmargin 0
set size 1,0.5
set origin 0,0.5   
set title "(a) TEST"
splot [0:147][0:110] "./testcg.TVNO2PD.txt" matrix notitle 
splot [0:147][0:110] "state_us36.lam1" u ($1):($2):1 notitle  w l lt -1 
unset label
