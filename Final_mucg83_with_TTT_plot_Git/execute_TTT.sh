#!/bin/bash

#Compile and run the Fortran Code 
gfortran mucg83.f -o mucg83
./mucg83


# Use grep to extract the numeric values from the file and save them into specific variables
#Bs1=$(grep -oP 'FERRITE START TEMPERATURE\s+=\s+\K\d+' OUT.DAT)
Bs=$(grep -oP 'GROWTH LIMITED BAINITE START TEMPERATURE\s+=\s+\K\d+' OUT.DAT)
Ms=$(grep -oP 'MARTENSITE START TEMPERATURE\s+=\s+\K\d+' OUT.DAT)

# Output the extracted values
#echo "Ferrite Start Temperature: $Bs1"
#echo "Bainite Start Temperature: $Bs"
#echo "Martensite Start Temperature: $Ms"

# Add variable names to the first row and variable values from the second row onward
# Modify the first row to add text "Bs" and "Ms", and add variable values from the second row onward
awk -v Bs="$Bs" -v Ms="$Ms" 'NR==1 {print $0, "Bs", "Ms"; next} {print $0, Bs, Ms}' PLOT.DAT > PLOT_MODIFIED.DAT

chmod +x plot_TTT.plt 
gnuplot plot_TTT.plt 

mkdir OUTPUT
mv mucg83 OUT.DAT PLOT.DAT PLOT_MODIFIED.DAT TTT_new.png OUTPUT/

echo "-------------------------------------------------------------------------------------------------------------------------------"
echo "Calculations have been completed"
echo "Enjoy exploring your TTT diagrams!"