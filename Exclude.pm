package Exclude;

use strict;
use warnings;
use experimental 'smartmatch';
use utf8;
use Scalar::Util qw(looks_like_number);

use Exporter;

our @ISA= qw( Exporter );

# these are exported by default.
our @EXPORT = qw( shouldExclude );

my $filename = 'exludelist.txt';
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";
 
chomp(my @excludeArray = <$fh>);

sub shouldExclude {
  my $word = $_[0];
  if (looks_like_number($word) || $word ~~ @excludeArray) {
    return 1;
  } else {
    return 0;
  }
}

1;
