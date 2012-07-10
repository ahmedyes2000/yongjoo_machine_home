#!/usr/bin/perl
# script: directory_to_URL_network.pl
# functionality: Create a URL based netword out of a hyperlinked collection
# functionality: of html pages. The output is a file in edgelist format.

use strict;
use warnings;
sub usage;
use Getopt::Long;

use File::Spec;
use HTML::LinkExtor;



my $output = "";
my $directory = "";

my $res = GetOptions("output=s" => \$output,
                     "directory=s" => \$directory);

if (!$res or ($output eq "") or ($directory eq "")) {
        usage();
        exit;
}


open OUTPUT,">$output";

open FILE,"find $directory -type f -print|";
my @files = <FILE>;
chomp(@files);
my $cur_dir=`pwd`;
chomp($cur_dir);
my @file_links=();
my %seen_links=();
my $i=0;
foreach my $file (@files){
        chdir($cur_dir);
        %seen_links=();
        $i++;
        print "$i  File: $file\n\n";
        @file_links=();
        my $parser = HTML::LinkExtor->new(\&cb);
        $parser->parse_file($file);
        my @parse = $parser->links;
        my ($vol, $dir, $name) = File::Spec->splitpath($file);
        my $path = File::Spec->catpath( $vol, $dir, '' );
        chdir($path);
        my $abs_path_src = File::Spec->rel2abs( $name ) ;
        foreach my $link (@file_links){
           if($link !~ m/^http:\/\//){
               if($link =~ m/^\//){
                 $link = substr $link,1;
               }
               my $abs_path_dest = File::Spec->rel2abs( $link ) ;
               my ($vol2, $dir2, $name2) = File::Spec->splitpath($abs_path_dest);
               my $abs_path_dest2 = File::Spec->rel2abs( $name2 ) ;
               if($abs_path_src ne $abs_path_dest2){
                   if ((-e $abs_path_dest) && (-f $abs_path_dest)) {
                        if(not defined $seen_links{$abs_path_src}){
                                 $seen_links{$abs_path_src}=();
                                 $seen_links{$abs_path_src}{$abs_path_dest}=1;
                                 print OUTPUT "$abs_path_src $abs_path_dest\n";
                        }else{
                                if(not defined $seen_links{$abs_path_src}{$abs_path_dest}){
                                      $seen_links{$abs_path_src}{$abs_path_dest}=1;
                                      print OUTPUT "$abs_path_src $abs_path_dest\n";
                                }
                        }
                    }
                }
            }
            chdir($path);
        }
        undef %seen_links;
}


close FILE;
close OUTPUT;

sub cb {
           my($tag, %links) = @_;
           return if $tag ne 'a';
           push @file_links, values %links
}

#
# Print out usage message
#
sub usage
{
        print "usage: $0 --directory dir --output out_file\n\n";
        print "  --directory dir\n";
        print "       The directory in which the collection of html pages are located\n";
        print "  --output out_file\n";
        print "       Name of output file\n";
        print "\n";
        print "example: $0 --directory chemical --output chemical.graph\n";
        print "\n";
        exit;
}

