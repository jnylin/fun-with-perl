#!/usr/bin/perl
#
# A simple example of references

sub change_name {
	$arr = \@_;
	@{$arr}[2] = "Alfred";
	@_[0] = "Jack";
}

@names = qw(
	Jakob
	Nils
	Olof
);

print @names;
print "\n";

change_name @names;

print @names;
print "\n";

