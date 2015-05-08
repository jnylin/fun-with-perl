#!/usr/bin/env perl
#
# Cleans a given HTML stanza from style attributes and span elements
# »» is supposed to be a list item and is replaced with <li>

use strict;
use warnings;

my $str_html = "";
my $nr_list_items = 0;

while (<>) {
	my $line = $_;

	# Ta bort style-attribut
	while ( $line =~ s/(<.*) style="[^>]*"([>, ])/$1$2/ ) {};

	# Fixa listor 
	# öppna med ul
	while ( $line =~ s/»» (.*)/<li>$1/ ) {
		if ( $nr_list_items == 0 ) {
			$str_html .= '<ul>';
			$nr_list_items++;
		}
	}
	# stäng ul efter sista li
	unless ( $line =~ /<li>/ ) {
		if ( $nr_list_items > 0 ) {
			$str_html .= '</ul>';
			$nr_list_items = 0;
		}
	}

	# Ta bort <span>-element
	$line =~ s/<\/{0,1}span>//g;

	$str_html .= $line;
}

# Skriv resultatet
print $str_html;

