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

my @excludeArray = qw(en to tre fire fem seks syv sju åtte ni ti ja nei stadig mennesker i og det er av som til på en for at å med har de ikke den om han et var fra men seg kan vi vil jeg ble skal så etter dette også ved sier hadde da eller være hun år blir ut nå over andre må mot bare alle du når få enn ha denne opp to bli noe sin inn man mer selv går vært gs noen 1 kunne før mange slik 2 nye der kroner mellom under får flere sa første norge hvor dag dem både her h3 hva ingen 3 ville prosent ham kommer store skulle siden fikk annet sine mener norske 000 hele alt kom disse hans 4 uten blitt blant ta 5 h1 tre p samme oss mye oslo meg helt siste gang tidligere sammen tid hvis 0 nok millioner derfor sitt igjen gå h5 norsk bør gjennom gikk ny mens godt fått gjøre se stor gir fordi 6 h4 ser gjør rundt gi ned grunn gjelder langt del 7 a måtte står forhold annen folk tilbake si komme henne like tatt bedre imidlertid aldri mest først tar allerede 8 rett 10 litt bergen større saken hvordan politiet mulig hos sett kanskje dersom);
sub shouldExclude {
  my $word = $_[0];
  if (looks_like_number($word) || $word ~~ @excludeArray) {
    return 1;
  } else {
    return 0;
  }
}

1;
