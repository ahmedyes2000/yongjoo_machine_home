# script: test_lexrank_large_mxt.t
# functionality: Test lexrank calculation on a network having used MxTerminator
# functionality: as the tool to split sentences. 

use strict;
use warnings;
use FindBin;
use Test::More;

use Clair::Config;

use vars qw($SENTENCE_SEGMENTER_TYPE $JMX_HOME);
my $old_SENTENCE_SEGMENTER_TYPE = $SENTENCE_SEGMENTER_TYPE;

if (defined $JMX_HOME) {
    $SENTENCE_SEGMENTER_TYPE = "MxTerminator";
    plan(tests => 10);
} else {
    plan(skip_all => "No path assigned to Clair::Config::JMX_HOME.  Test skipped.");
}

use_ok('Clair::Network');
use_ok('Clair::Network::Centrality::LexRank');
use_ok('Clair::Cluster');
use_ok('Clair::Document');
use_ok('Clair::Util');


my $file_gen_dir = "$FindBin::Bin/produced/lexrank_large";
my $file_input_dir = "$FindBin::Bin/input/lexrank_large";
my $file_exp_dir = "$FindBin::Bin/expected/lexrank_large";

my $c = new Clair::Cluster();

$c->load_documents("$file_input_dir/*", type => 'html', count_id => 1);
$c->strip_all_documents();
$c->stem_all_documents();

is($c->count_elements, 3, "count_elements");
my $sent_n = $c->create_sentence_based_network;

is($sent_n->num_nodes(), 44, "num_nodes");
# is($sent_n->num_nodes(), 25, "num_nodes");

my %cos_matrix = $c->compute_cosine_matrix(text_type => 'stem');

my $n = $c->create_network(cosine_matrix => \%cos_matrix);

my $cent = Clair::Network::Centrality::LexRank->new($n);
$cent->centrality();
$cent->save_lexrank_probabilities_to_file("$file_gen_dir/lex1_prob");
ok(compare_proper_files("lex1_prob"), "save_lexrank_probabilities_to_file" );

my $lex_network = $n->create_network_from_lexrank(0.33);
is($lex_network->num_nodes, 2, "num_nodes");

my $lex_cluster = $n->create_cluster_from_lexrank(0.33);
is($lex_cluster->count_elements(), 2, "count_elements");

$SENTENCE_SEGMENTER_TYPE = $old_SENTENCE_SEGMENTER_TYPE;

# Compares two files named filename
# from the t/docs/expected directory and
# from the t/docs/produced directory
sub compare_proper_files {
  my $filename = shift;

  return Clair::Util::compare_files("$file_exp_dir/$filename", "$file_gen_dir/$filename");
}

