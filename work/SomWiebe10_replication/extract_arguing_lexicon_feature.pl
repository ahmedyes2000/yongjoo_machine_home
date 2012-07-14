#!/usr/bin/perl -w
use strict;
use IO::Handle;
STDERR->autoflush(1);
STDOUT->autoflush(1);

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
close IN;


open IN, "inter/pre_process2.txt" or die;
while (<IN>) {
    chomp;
    my ($domain, $label, $post_id, $sent_id, $sent) = split /\t/, $_;
    my $sent_pos = 0;
    my $sent_neg = 0;
    $sent =~ s/^\s+//g;
    $sent =~ s/\s+$//g;
    my @words = split /\s+/, $sent;
    print $_."\t";
    # search for trigram in the arguing lexicon
    my $i = 0;
    while ($i <= $#words-2 ) {
        if (not defined ($words[$i]) or not defined ($words[$i+1]) or not defined ($words[$i+2]) ) {
            $i ++;
            next;
        }
        my $trigram = $words[$i]."_".$words[$i+1]."_".$words[$i+2];
        if (exists $p_pos{$trigram}) {
            print " $trigram"; 
            $sent_pos += $p_pos{$trigram};
            $sent_neg += $p_neg{$trigram};
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
        if (not defined ($words[$i]) or not defined ($words[$i+1]) ) {
            $i ++;
            next;
        }
        my $bigram = $words[$i]."_".$words[$i+1];
        if (exists $p_pos{$bigram}) {
            print " $bigram"; 
            $sent_pos += $p_pos{$bigram};
            $sent_neg += $p_neg{$bigram};
            delete $words[$i];
            delete $words[$i+1];
            $i += 2;
        } else {
            $i ++;
        }
    }
    $i = 0;
    while ($i <= $#words) {
        if (not defined ($words[$i]) ) {
            $i ++;
            next;
        }
        my $unigram = $words[$i];
        if (exists $p_pos{$unigram}) {
            print " $unigram";
            $sent_pos += $p_pos{$unigram};
            $sent_neg += $p_neg{$unigram};
            delete $words[$i];
        }
        $i ++;
    }
    my $sent_pol = "ap";
    $sent_pol = "an" if ($sent_neg > $sent_pos);
    print "\t$sent_pos\t$sent_neg\t$sent_pol\n";
}


