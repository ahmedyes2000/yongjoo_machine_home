#!/usr/bin/perl

# script: random_walk.pl
# functionality: Random Walk on a graph.

use strict;
use warnings;

use Getopt::Long;

use Clair::Network;
use Clair::Network::Reader::Edgelist;
use Clair::RandomWalk;
sub usage;

my $output_file = "";
my $graph_file = "";
my $transition_file="";
my $initial_prop = "";
my $verbose=0;
my $stationary=0;
my $steps=100;
my $rounds=1000;
my $start_node;



my $res = GetOptions("graph=s" => \$graph_file,
                     "output=s" => \$output_file,
                     "transition_file=s" => \$transition_file,
                     "initial_distribution" => \$initial_prop,
                     "stationary!" => \$stationary,
                     "steps=i" => \$steps,
                     "rounds=i" => \$rounds,
                     "start_node=s" => \$start_node,
                     "verbose!" => \$verbose);



if (!$res or ($graph_file eq "")) {
        usage();
        exit;
}

my $reader = new Clair::Network::Reader::Edgelist();
my $net = $reader->read_network($graph_file);

use Data::Dumper;

my @nodes = $net->get_vertices();

my $rn = new Clair::RandomWalk($net,$start_node);

if($transition_file ne ""){
        $rn->load_transition_probabilities_from_file($transition_file);
}else{
        $rn->set_uniform_transition_probabilities();
}


if($initial_prop){
        $rn->load_initial_probability_distribution_from_file($initial_prop);
}else{
        $rn->set_uniform_initial_probability_distribution();
}


if($stationary){
        $rn->compute_stationary_distribution();
}else{
        $rn->compute_porbability_distribution($rounds,$steps);
}

if($output_file ne ""){
        $rn->wrtie_porbability_distribution_to_file($output_file);
}else{
        $rn->print_current_probability_distribution();
}

#
# Print out usage message
#
sub usage
{
        print "usage: $0 --graph graph_file [--transition_file file] [--initial_distribution file] [--output out_file] [--stationary | --rounds rounds_num --steps steps_num] [--verbose]\n\n";
        print "  --graph file\n";
        print "       Name of input graph file in edgelist format\n";
        print "  --output file\n";
        print "       Name of output file where the probability distribution after the walk will be written. If not specified, the result will be printed on the screen\n";
        print "  --transition_file file\n";
        print "       The transition probability in the format (src_node dest_node trans_prob). If not specified, the probability of an edge will be set to 1/(out degree of source node)\n";
        print "  --initial_distribution file\n";
        print "       The initial probability distribution in the format (node prob). If not specified, the probability of a node will be set to 1/(number of nodes)\n";
        print "  --steps number\n";
        print "       Number of random steps to walk in each round during the computation of the probability distribution\n";
        print "  --rounds number\n";
        print "       Number of times to repeat the random walk to compute the probability distribution\n";
        print "  --start_node node\n";
        print "       The node from which the random walk should start\n";
        print "  --verbose\n";
        print "       Preserve the order of the sentences in the summary as they were in the input\n";

        print "\n";

        print "example: $0 --graph net.graph --transition_file trans --initial_distribution init --output probs --stationary\n";

        exit;
}
