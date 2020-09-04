set datafile separator "," 

set xdata time

set timefmt "%Y-%m"
set ytics norangelimit

set title "Std Deviation Sep 2019 Sep 2020"
set key outside
set lmargin 15
set rmargin 15

set grid
set output "std_deviation.png"
plot 'std_deviation.csv' using 1:2 title 'std-deviation' with lp pt 7 ps 1 

