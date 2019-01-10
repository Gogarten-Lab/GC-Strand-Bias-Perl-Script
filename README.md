# GC-Strand-Bias-Perl-Script
Calculates the cumulative GC strand bias as C - G excess along a DNA strand
The script takes a single sequence in fasta format (extension .fna) and calculates the excess of Cs (over Gs) in a cumulative manner.  Results are written to a table called "my_table".  

The script needs to be in the same directory as the sequence to analyze.  Sorry, you need to have different directories for each genome you want to analyze.  

You can edit the script to change how often results are written to the table.  
The script also calculates the A over T and keto base excess in the strand.  THis can be easily changed to report other biases.  

The column with the CG Bias is a useless leftover (aside possible for the last value.  It makes no sense to calculate the bias in a cumulative fashion.)  

The table can be imprted into excel and the C over G excess be plottes as a scatterplot.  (or use gnuplot, or R) 

To run the script the sequence (with .fna extension) need to be in the same directory as the script.  

perl GCskew.pl will start the script 
