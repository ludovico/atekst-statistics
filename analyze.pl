#!/usr/bin/perl

use strict;
use warnings;


use lib ('./');
use Exclude;
binmode(STDOUT, ":utf8");

# Setup
my $articleSeparator = "==============================================================================";

# Init Data file
#my $filename = 'bigdata.txt'; # Get name from command line?
my $filename = 'testdata.txt'; # Get name from command line?
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";

my $articleCount = 0;
#my %articleStats;
my %totalStats;

while(my $row = <$fh>) {
  chomp($row);

  # If finished article, print collected data (DB later)
  if($row eq $articleSeparator) {

    #print "\n\n\nArticle ".++$articleCount.":\n";
    #print "Word statistics\n-----------------\n";

    #foreach my $str (sort { $articleStats{$a} <=> $articleStats{$b} }  keys %articleStats) {
    #if($articleStats{$str} > 1) {
    #printf "%-31s %s\n", $str, $articleStats{$str};
    #}
    #}
    #undef %articleStats;

  } else {

    foreach my $str ($row =~ /\w+/g) {
      #$articleStats{lc($str)}++;
      $totalStats{lc($str)}++;
    }

  }
}

print "Total statistics\n-----------------\n";
foreach my $str (sort { $totalStats{$a} <=> $totalStats{$b} }  keys %totalStats) {
  if(!shouldExclude($str)) {
    printf "%-31s %s\n", $str, $totalStats{$str};
  }
}
