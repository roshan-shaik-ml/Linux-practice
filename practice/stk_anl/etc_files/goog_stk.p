set datafile separator ","

set xdata time

set timefmt "%Y-%m-%d"
set ytics norangelimit
set yrange [1100 : 1700]
set title "GOOG Sep 2019 Sep 2020"
set key outside
set lmargin 15
set rmargin 15

set grid
set output "stock_goog.png"
plot 'goog.csv' using 1:5 title 'Closed' with lp pt 7 ps 1,\
'goog.csv' using 1:2 title 'Open' with lp pt 6 lc 7 ps 1  
 
