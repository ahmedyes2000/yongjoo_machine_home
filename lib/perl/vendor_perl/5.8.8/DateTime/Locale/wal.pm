###########################################################################
#
# This file is auto-generated by the Perl DateTime Suite time locale
# generator (0.04).  This code generator comes with the
# DateTime::Locale distribution in the tools/ directory, and is called
# generate_from_cldr.
#
# This file as generated from the CLDR XML locale data.  See the
# LICENSE.cldr file included in this distribution for license details.
#
# This file was generated from the source file wal.xml.
# The source file version number was 1.47, generated on
# 2007/07/19 22:31:40.
#
# Do not edit this file directly.
#
###########################################################################

package DateTime::Locale::wal;

use strict;

BEGIN
{
    if ( $] >= 5.006 )
    {
        require utf8; utf8->import;
    }
}

use DateTime::Locale::root;

@DateTime::Locale::wal::ISA = qw(DateTime::Locale::root);

my @day_names = (
"ሳይኖ",
"ማቆሳኛ",
"አሩዋ",
"ሃሙሳ",
"አርባ",
"ቄራ",
"ወጋ",
);

my @day_abbreviations = (
"ሳይኖ",
"ማቆሳ",
"አሩዋ",
"ሃሙሳ",
"አርባ",
"ቄራ",
"ወጋ",
);

my @day_narrows = (
"ሳ",
"ማ",
"አ",
"ሃ",
"አ",
"ቄ",
"ወ",
);

my @month_names = (
"ጃንዩወሪ",
"ፌብሩወሪ",
"ማርች",
"ኤፕረል",
"ሜይ",
"ጁን",
"ጁላይ",
"ኦገስት",
"ሴፕቴምበር",
"ኦክተውበር",
"ኖቬምበር",
"ዲሴምበር",
);

my @month_abbreviations = (
"ጃንዩ",
"ፌብሩ",
"ማርች",
"ኤፕረ",
"ሜይ",
"ጁን",
"ጁላይ",
"ኦገስ",
"ሴፕቴ",
"ኦክተ",
"ኖቬም",
"ዲሴም",
);

my @month_narrows = (
"ጃ",
"ፌ",
"ማ",
"ኤ",
"ሜ",
"ጁ",
"ጁ",
"ኦ",
"ሴ",
"ኦ",
"ኖ",
"ዲ",
);

my @quarter_names = (
"Q1",
"Q2",
"Q3",
"Q4",
);

my @quarter_abbreviations = (
"Q1",
"Q2",
"Q3",
"Q4",
);

my @am_pms = (
"ማለዶ",
"ቃማ",
);

my @era_abbreviations = (
"አዳ\ ዎዴ",
"ግሮተታ\ ላይታ",
);

my $date_before_time = "1";
my $date_parts_order = "dmy";


sub day_names                      { \@day_names }
sub day_abbreviations              { \@day_abbreviations }
sub day_narrows                    { \@day_narrows }
sub month_names                    { \@month_names }
sub month_abbreviations            { \@month_abbreviations }
sub month_narrows                  { \@month_narrows }
sub quarter_names                  { \@quarter_names }
sub quarter_abbreviations          { \@quarter_abbreviations }
sub am_pms                         { \@am_pms }
sub era_abbreviations              { \@era_abbreviations }
sub full_date_format               { "\%A፥\ \%d\ \%B\ ጋላሳ\ \%\{ce_year\}\ \%\{era\}" }
sub long_date_format               { "\%d\ \%B\ \%\{ce_year\}" }
sub medium_date_format             { "\%d\-\%b\-\%\{ce_year\}" }
sub short_date_format              { "\%d\/\%m\/\%y" }
sub full_time_format               { "\%\{hour_12\}\:\%M\:\%S\ \%p\ v" }
sub long_time_format               { "\%\{hour_12\}\:\%M\:\%S\ \%p\ \%\{time_zone_long_name\}" }
sub medium_time_format             { "\%\{hour_12\}\:\%M\:\%S\ \%p" }
sub short_time_format              { "\%\{hour_12\}\:\%M\ \%p" }
sub date_before_time               { $date_before_time }
sub date_parts_order               { $date_parts_order }



1;

