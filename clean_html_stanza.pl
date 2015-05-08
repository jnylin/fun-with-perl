#!/usr/bin/env perl

use strict;
use warnings;

my $f_htmlStanza = 'läkare.html';
open(my $fh, '<', $f_htmlStanza)
	or die "Could not open file '$f_htmlStanza' $!";

my $str_html = "";
my $nr_list_items = 0;

while (<$fh>) {
	my $str = $_;

	# Ta bort style-attribut
	while ( $str =~ s/(<.*) style="[^>]*"([>, ])/$1$2/ ) {};

	# Fixa listor (<li> behöver inte stängas)
	# <ul> innan första och </ul> efter sista
	while ( $str =~ s/»» (.*)/<li>$1/ ) {
		if ( $nr_list_items == 0 ) {
			$str_html .= '<ul>';
			$nr_list_items++;
		}
	}
	unless ( $str =~ /<li>/ ) {
		if ( $nr_list_items > 0 ) {
			$str_html .= '</ul>';
			$nr_list_items = 0;
		}
	}

	# Ta bort <span>-element
	$str =~ s/<\/{0,1}span>//g;

	#Skriv resultatet
	$str_html .= $str;
}

print $nr_list_items;
print $str_html;

