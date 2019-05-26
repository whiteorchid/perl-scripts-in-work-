#!/usr/bin/perl
###perl $0 bed.txt vcf.txt result.txt
use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;
use FindBin qw($Bin $Script);
use File::Basename qw(basename dirname);
#############################################
#read
my $i;
my %hash1;
my $pos;
open IN,"<$ARGV[0]" or die $!;
while (<IN>){
	chomp;
	next if $_ =~ /^#/;
	#next if $_ =~ /^$/;
	my @arr =  split /\t/,$_;
	my ($chr,$start,$end) = @arr[0,1,2];

	for($i=0;$i<($end - $start);$i++){
		$pos = $start + $i;
		$hash1{$arr[0]}{$pos} = $_.$i;
	}
}
close IN;
#######################################
#read file

open IN,"<$ARGV[1]" or die $!;
open OUT,">$ARGV[2]" or die $!;
while (<IN>){
        chomp;
        next if $_ =~ /#/;
        #next if $_ =~ /^$/;
	my @arr =  split /\t/,$_;

	if (exists $hash1{$arr[0]}{$arr[1]}){
		print OUT "$_\n";
	}
}


close IN;
close OUT;

