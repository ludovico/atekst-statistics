#!/usr/bin/perl

use strict;
use warnings;


use lib ('./');
use Exclude;
use Dumpvalue;
binmode(STDOUT, ":utf8");

# Setup
my $articleSeparator = "==============================================================================";
my $titleSeparator = "------------------------------------------------------------------------------";

# Flags
my $newArticle = 0;
my $readTitle = 0;

# Read variables
my $publication = "";
my $year = 0;

# Init Data file
my $filename = 'textdata.txt'; # Get name from command line?
open(my $fh, '<:encoding(UTF-8)', $filename)
	or die "Could not open file '$filename' $!";

my $articleCount = 0;
#my %articleStats;
my %totalStats;

while(my $row = <$fh>) {
	chomp($row);

	if($newArticle == 1) {
		$newArticle = 0;
		next;
	}

	# Read publication and date
	if($readTitle == 1) {
		($publication, $year) = split('/, \d\+\.\d\+\./', $row);

		$readTitle = 0;
		next;
	}

	if($row eq $titleSeparator) {
		$readTitle = 1;
		next;
	}

	# If finished article, print collected data (DB later)
	if($row eq $articleSeparator) {
		$newArticle = 1;
		next;
	}

	# Needs publication and year data
	if($publication eq "" || $year == 0) {
		next;
	}

	foreach my $str ($row =~ /\w+/g) {
		#$articleStats{lc($str)}++;
		$totalStats{lc($year)}{lc($publication)}{lc($str)}++;
	}
}

my $dump = Dumpvalue->new;
print $dump.stringify(%totalStats);
#print "Total statistics\n-----------------\n";
#foreach my $str (sort { $totalStats{$a} <=> $totalStats{$b} }  keys %totalStats) {
#if(!shouldExclude($str)) {
#printf "%-31s %s\n", $str, $totalStats{$str};
#}
#}
