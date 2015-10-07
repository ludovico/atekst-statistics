#!/usr/bin/perl

use strict;
use warnings;
use open qw/:std :utf8/;


use lib ('./');
use Exclude;
use Data::Dumper;
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

	# Read publication and date
	if($readTitle == 1) {
		my $loff = $row;
		if($loff =~ /^\s*$/) {
			$readTitle = 0;
			next;
		}

		my $loff2 = $row;
		if($loff2 !~ /, \d+\.\d+\.\d+/) {
			next;
		}


		# Extract year, publisher
		($publication, $year) = split(/, \d+\.\d+\./, $row);

		# "clean" $year var
		$year = substr $year, 0, 4;

		next;
	}

	if($row eq $titleSeparator) {
		$readTitle = 1;
		next;
	}

	# If finished article, print collected data (DB later)
	#if($row eq $articleSeparator) {
	#$newArticle = 1;
	#next;
	#}

	# Needs publication and year data
	if($publication eq "" || $year == 0) {
		next;
	}

	foreach my $str ($row =~ /\w+/g) {
		$totalStats{lc($year)}{lc($publication)}{lc($str)}++;
	}
}

print "øØØØlkjåqwerlkj";
print Dumper(%totalStats);

