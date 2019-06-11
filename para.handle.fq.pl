#/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use Data::Dumper;
use FindBin qw($Bin $Script);
use File::Basename qw(basename dirname);
use Cwd qw(abs_path getcwd);

my $dir=getcwd;
my ($fq1,$fq2,$o1,$o2);

opendir(DIR, "$dir/Input2") || die "Error in opening dir $dir";
my @subdir = readdir DIR;

foreach my $sub (@subdir){

	next if $sub eq '.';
	next if $sub eq '..';
		
	print("reading directory $dir/$sub\n");      
	my @fq1 = glob "$dir/Input2/$sub/*R1.fq.gz";
	my @fq2 = glob("$dir/Input2/$sub/*R2.fq.gz");
	$fq1 = shift @fq1;print "$fq1\n";
	$fq2 = shift @fq2;print "$fq2\n";
	# my $od="$dir/Input2/$sub";
	# print "test  $od\n";
	system("touch $dir/Input2/$sub/R1.fastq.list");
	system("touch $dir/Input2/$sub/R2.fastq.list");
	system("echo $fq1 > $dir/Input2/$sub/R1.fastq.list");
	system("echo $fq2 > $dir/Input2/$sub/R2.fastq.list");
	
	$o1 = $1 if (basename $fq1) =~ /(.*).fq.gz/;
	$o2 = $1 if (basename $fq2) =~ /(.*).fq.gz/;
	open SH,">$dir/Input2/$sub/down.sh" or die $!;
	print SH "#!/bin/bash\nfastq_downsize_multi -1 $dir/Input2/$sub/R1.fastq.list -2 $dir/Input2/$sub/R2.fastq.list -o1 $dir/Input2/$sub/$o1.downsized.fastq -o2 $dir/Input2/$sub/$o2.downsized.fastq  -n 10G";
	
	close SH;
	`sbatch -p P1  $dir/Input2/$sub/down.sh`;

}

closedir DIR;

