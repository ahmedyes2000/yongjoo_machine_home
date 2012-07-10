#!/usr/local/bin/perl

# script: test_cfnetwork_basic.pl
# functionality: Creates a small network to demonstrate the CFNetwork object

use strict;
use warnings;
use FindBin;
use Clair::Network;
use Clair::Network::CFNetwork;


#  This file shows the basics of how to use the CFNetwork object.
#  Here, a small, simple network is explictly created.

my $basedir = $FindBin::Bin;
my $gen_dir = "$basedir/produced/cfnetwork";

my $prefix = "basic";
my $cfn = Clair::Network::CFNetwork->new(name => $prefix);

## BUILD THE NETWORK

$cfn->add_node(1,label => "A");
$cfn->add_node(2,label => "B");
$cfn->add_node(3,label => "C");
$cfn->add_node(4,label => "D");
$cfn->add_node(5,label => "E");
$cfn->add_node(6,label => "F");
$cfn->add_weighted_edge(1,2,2);  # edge weight of 2
$cfn->add_edge(2,3);             # default edge weight of 1
$cfn->add_edge(1,3);
$cfn->add_edge(3,4);
$cfn->add_edge(4,5);
$cfn->add_edge(5,6);
$cfn->add_weighted_edge(4,6,1);


## PRINT SOME NETWORK STATISTICS

my @nodes = $cfn->get_vertices;
my @edges = $cfn->get_edges;

print "There are ", $cfn->num_nodes, " nodes in the network\n";
print "There are ", $cfn->num_links, " edges in the network\n";
print " m = ", $cfn->getM, "\n";

foreach(sort  @nodes ) {

    print " NODE:  $_  (", $cfn->get_vertex_attribute($_,"label");
    print ") Degree = ", $cfn->total_degree($_);
    print "   Node k = ", $cfn->calc_k($_), "\n";

}

foreach(  @edges ) {

    print " EDGE:  ${$_}[0] -- ${$_}[1] ";
    print "  has weight ", $cfn->get_edge_weight(${$_}[0],${$_}[1]), "\n";

}

## TEST TO SEE IF THE NEWORK IS CONNECTED

if( $cfn->isConnected ) { print "The network is connected.\n";}
else { print "The network is not connected.\n"; }


## FIND COMMUNITIES WITHIN THE NETWORK

$cfn->communityFind(dirname => $gen_dir);


## EXPORT RESULTS TO A PAJEK PROJECT FILE

$cfn->export2PajekProject(partition => 'best', dirname => $gen_dir);
