set datafile separator ","

set xdata time

set timefmt "%Y-%m"
set ytics norangelimit
set yrange [1100 : 1700]
set title "GOOG Sep 2019 Sep 2020"
set key outside
set lmargin 15
set rmargin 15

set grid
set output "plot_goog.png"
plot 'plot_goog.csv' using 1:2 title 'month-avg' with lp pt 7 ps 1,\
 
