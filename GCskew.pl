#!/usr/bin/perl -w

#initialize genome name and base_hash
$my_genome = "";
%base_hash=();

#assign genome name to $my_genome
@dir=`ls`;
foreach (@dir) {
   if (m/\.fna$/) {if ($my_genome) {die "More then one genome in directory"} else {$my_genome=($_)}
   }
}
######
chomp ($my_genome);

print "\n\n$my_genome is the file name of the genome to be analyzed \n";

# open my genome for input

open (IN, "< $my_genome") or die "cannot open $my_genome:$!";

# open my_table for output

open (OUT, ">my_table" ) or die "cannot open my_table" ;

print OUT "number \tketoexcess\tCoverGskew\tAoverTskew\tGCbias\tbase_hash{A}\tbase_hash{T}\tbase_hash{G}\tbase_hash{C}\n";# if we want to use exel, we can print a header in the first line";

$header = <IN>;
#reads first line of file, next command test for fasta commentline

if ($header =~m/^>/) {print "\nthe analyzed genome has the following comment line:\n$header \n\n"};

if (!($header =~m/^>/)) {print "this is not in FASTA format \n\n";
			exit;}
###			exit - could have died instead;

$number=0;

while (defined ($line=<IN>)){

#initialise @bases within loop
# potential problem: this reads and analyses line by line.  
#It might be better, especially if one wants to use nucleotide pairs or oligod, to read everthing in first
        @bases=();
	chomp($line);

    @bases=split(//,$line);

	foreach (@bases) {
	   $number += 1;
	   $base_hash{$_} += 1;#counts As,Gs and Cs and Ts
#every 50 nucleotides, print stuff to file
#depending on the sequence you analyze, this can be a large file.  You can change the 50 in the following line to a larger or smaller number.  For a genome 1000 workes fine, for an overall image, if you want to pinpoint a turning point in strand bias, use 5.
	   if ($number%50==0){
	   $gcscew=($base_hash{C}-$base_hash{G});
	   $atscew=($base_hash{A}-$base_hash{T});
	   $ketoexcess=($base_hash{G}+$base_hash{T})-($base_hash{A}+$base_hash{C});
	   $gcbias=(($base_hash{C}-$base_hash{G})/($base_hash{C}+$base_hash{G}));
	   print OUT "$number\t$ketoexcess\t$gcscew\t$atscew\t$gcbias\t$base_hash{A}\t$base_hash{T}\t$base_hash{G}\t$base_hash{C}\n";# if we want to use exel, we can print a header in the first line
	   }
	}
}

close(IN);
close(OUT);

##@bases_used = keys(%base_hash);

foreach (keys(%base_hash)) {
    print "base symbol \t $_ \t occurred $base_hash{$_}   times\n";
    $total_bp += $base_hash{$_}
}
print "\nthe genome contains $total_bp base pairs\n";


#calculate GC content

$GC_content = 100*($base_hash{C} + $base_hash{G})/$total_bp ;

printf "\nGC-content= %.2f percent \n", $GC_content;

exit;


