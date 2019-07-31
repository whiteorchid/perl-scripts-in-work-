#!/usr/bin/perl

#my $base;
open IN,"<",$ARGV[0] or die $!;
#my $head = <IN>;
open OUT,">",$ARGV[1] or die $!;
#print OUT $head;

while (<IN>){
	chomp;
	if (/^Variant/){
		
		my @head = split /\t/,$_;
                shift @head;
                unshift  @head,"Ref";
                unshift @head,"Variant";
		unshift @head,"Chromosome";		
#		print "@head\n";
                print OUT join ("\t",@head),"\n";
                next;	
	}
	
	my @arr = split /\t/,$_;
	my @info = split /\|/,$arr[0];
	$base = $info[1];
	my $pos = $info[0];
	$pos =~ s/D//g; ###   delete D  2019.07.31
	$pos = $pos + 817351712; #####  add number  ;  2019.07.31 
	#print $base;
	for (my $i=0;$i < @arr;$i++){
		if ($arr[$i] =~/-/){
			$arr[$i] = $base; ###$base
		#	print $arr[$i];
		}else{ $arr[$i] = "deleted";} ### if not "-", change "-" to REF base ##2019.07.31
	#print OUT @arr,"\n";	
	}
	
	shift @arr;
	print OUT join("\t",("Chr3B",$pos,$base,@arr)),"\n";
}

close IN;
close OUT;

 


