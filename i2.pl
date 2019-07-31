#!/usr/bin/perl

my $base;
open IN,"<",$ARGV[0] or die $!;
#my $head = <IN>;
open OUT,">",$ARGV[1] or die $!;
#print OUT $head;

while (<IN>){
	chomp;
	if (/Variant/){
		chomp;
		my @head = split /\t/,$_;
		shift @head;
		#unshift @head,"Ref";
		unshift @head,"Variant"; 
		unshift @head, "Chromsome"; ########  add one column
		print OUT join ("\t",@head),"\n"; 
		next;	
	}
	
	my @arr = split /\t/,$_;
	my @info = split /\|/,$arr[0];
	$base = $info[1];
	my $pos = $info[0]; ##### 100I101  2019.07.31
	my @p = split/I/,$pos; ### split  to 2 element   2019.07.31
	$p[0] = $p[0] + 817351712;  ###add number   2019.07.31
	$p[1] = $p[1] + 817351712;  #### add number  2019.07.31
	$pos = $p[0]."I".$p[1]; ####  combine togeter   2019.07.31
	#print $base;
	#
	for (my $i=0;$i < @arr;$i++){
		if ($arr[$i] =~ /\d/){ #### if match number , change it to ref base 2019.7.31
			$arr[$i] = $base;
		#	print $arr[$i];
		}
	#print OUT @arr,"\n";	
	}
	shift @arr;
	print OUT join ("\t",("Chr3B",$pos,@arr)),"\n";    ###   add one column
}

close IN;
close OUT;

 


