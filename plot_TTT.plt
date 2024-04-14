#!/usr/bin/gnuplot

reset
#set terminal pngcairo enhanced size 1024,768 font "Helvetica, 30"
set terminal pngcairo enhanced size 950,1024 font "Helvetica, 30"
set output 'TTT_new.png'
set title 'TTT Diagram'
set xlabel 'Time / s'
set ylabel 'Temperature / °C'
#set nokey
set key top right
set key samplen 3 spacing 2 font ",20"
set logscale x
#set logscale y
#set xtics 1000
#set format x '%.1t+E%T
#set format y '%.0t+E%T
set format x "10^{%L}"
#set format y "10^{%L}"
set xrange [0:]
set yrange [20:]
#set format y "0.%E";
#set format y '%.0s*10^%S'
set tics nomirror
set tics out
set style line 1 \
    linecolor rgb '#A00000' \
    linetype 1 linewidth 4 \
    pointtype 7 pointsize 1
set style line 2 \
    linecolor rgb '#5060D0' \
    linetype 1 linewidth 4 \
    pointtype 7 pointsize 1
set style line 3 \
    linecolor rgb '#7FFF00' \
    linetype 1 linewidth 4 \
    pointtype 7 pointsize 1
set style line 4 \
    linecolor rgb '#FF8C00' \
    linetype 1 linewidth 4 \
    pointtype 7 pointsize 1
set style line 5 \
    linecolor rgb '#00FFFF' \
    linetype 1 linewidth 4 \
    pointtype 7 pointsize 1
set style line 6 \
    linecolor rgb '#333333' \
    linetype 1 linewidth 4 \
    pointtype 7 pointsize 1

# Define the coordinates of the point (x, y) to plot the Bs line
# Determine the maximum value in column 17 (The Bs Value)
stats 'PLOT_MODIFIED.DAT' using 17 nooutput
y = STATS_max
# Determine the maximum value in column 17 (The Bs Value)
stats 'PLOT_MODIFIED.DAT' using 15 nooutput
x = STATS_min

stats 'PLOT_MODIFIED.DAT' using 16 nooutput
xmin = STATS_min
xmax = STATS_max

# Determine the maximum value in column 18
stats 'PLOT_MODIFIED.DAT' using 18 nooutput
ymax = STATS_max

# Draw horizontal line from (x, y) to (xmax, y) This should be same as the linestyle used for ''Bs Temp
set arrow from x,y to xmax, y nohead lc rgb '#7FFF00' lw 4


plot  'PLOT_MODIFIED.DAT' using ($16):($4 > $17 ? $4 : 1/0) with points ls 2 title 'DIFFT', \
     'PLOT_MODIFIED.DAT' using ($15):($4 < $17 ? $4 : 1/0) with points ls 4 title 'SHEART', \
     'PLOT_MODIFIED.DAT' using ($15):($4 < $17 ? $17 : 1/0) with l ls 3 title 'Bs Temp', \
      'PLOT_MODIFIED.DAT' using ($16):($4 < $17 ? $17 : 1/0) with l ls 3 notitle, \
     ymax w l ls 1 title 'Ms Temp'



