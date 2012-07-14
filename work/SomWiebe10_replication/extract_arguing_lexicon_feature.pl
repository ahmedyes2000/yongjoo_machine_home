#!/usr/bin/perl -w
use strict;

my %p_pos;
my %p_neg;
my $arg_lex_file = shift;
open IN, "$arg_lex_file" or die;
while (<IN>) {
    chomp;
    my ($lex, $p_pos, $p_neg, $ttt)  = split /\t/, $_;
    $p_pos{$lex} = $p_pos;
    $p_neg{$lex} = $p_neg;
}


open IN, "inter/pre_process2.txt" or die;
while (<IN>) {
    chomp;
    my ($domain, $label, $post_id, $sent_id, $sent) = split /\t/, $_;
    my @words = split /\s+/, $sent;
    print $_."\t";
    # search for trigram in the arguing lexicon
    my $i = 0;
    while ($i <= $#words-2 ) {
        next if (not defined ($words[$i]) or not defined ($words[$i+1]) or not defined ($words[$i+2]) );
        my $trigram = $words[$i]."_".$words[$i+1]."_".$words[$i+2];
        if (exists $p_pos{$trigram}) {
            print " $trigram"; 
            delete $words[$i];
            delete $words[$i+1];
            delete $words[$i+2];
            $i += 3;
        } else {
            $i ++;
        }
    }
    # bigram
    $i = 0;
    while ($i <= $#words-1 ) {
        next if (not defined ($words[$i]) or not defined ($words[$i+1]) );
        my $bigram = $words[$i]."_".$words[$i+1];
        if (exists $p_pos{$bigram}) {
            print " $bigram"; 
            delete $words[$i];
            delete $words[$i+1];
            $i += 2;
        } else {
            $i ++;
        }
    }
    $i = 0;
    while ($i <= $#words) {
        next if (not defined ($words[$i]) );
        my $unigram = $words[$i];
        if (exists $p_pos{$unigram}) {
            print " $unigram";
            delete $words[$i];
        }
        $i ++;
    }
    print "\n";
}


