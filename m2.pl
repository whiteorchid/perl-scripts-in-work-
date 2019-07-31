#!/usr/bin/perl

my $base;
open IN,"<",$ARGV[0] or die $!;
#my $head = <IN>;
open OUT,">",$ARGV[1] or die $!;
#print OUT $head;

while (<IN>){
	chomp;
	if (/^Variant/){
		chomp;
                my @head = split /\t/,$_;
                shift @head;
                unshift @head,"Ref";
                unshift @head,"Variant";
		unshift @head,"Chrosome";
                print OUT join ("\t",@head),"\n";
        	next;        
		
	}
	
	my @arr = split /\t/,$_; ### split row 
	my @info = split /\|/,$arr[0]; ### split first element
	$base = $info[1];
	my @tmp= split /=>/,$base;
	$base = $tmp[0];  ####  this can be use to replace the "-" in each line 
	my $alt_base  = $tmp[1];
	  #####  get the base
	#print $base;
	my $pos = $info[0];
	$pos =~ s/M//;
	$pos = $pos + 817351712;
	for (my $i=0;$i < @arr;$i++){
		if ($arr[$i] ==1){ 
			$arr[$i] = $alt_base;  ##### change element to base if show 1  ==
		#	print $arr[$i];
		}else { $arr[$i] = $base;}
	#print OUT @arr,"\n";	
	}
	shift @arr;
	print OUT join("\t",("Chr3B", $pos,$base,@arr)),"\n";  ### save to new file, every row
}

close IN;
close OUT;

 


