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
# This file was generated from the source file te.xml.
# The source file version number was 1.62, generated on
# 2007/07/21 17:25:02.
#
# Do not edit this file directly.
#
###########################################################################

package DateTime::Locale::te;

use strict;

BEGIN
{
    if ( $] >= 5.006 )
    {
        require utf8; utf8->import;
    }
}

use DateTime::Locale::root;

@DateTime::Locale::te::ISA = qw(DateTime::Locale::root);

my @day_names = (
"సోమవారం",
"మంగళవారం",
"బుధవారం",
"గురువారం",
"శుక్రవారం",
"శనివారం",
"ఆదివారం",
);

my @day_abbreviations = (
"సోమ",
"మంగళ",
"బుధ",
"గురు",
"శుక్ర",
"శని",
"ఆది",
);

my @day_narrows = (
"2",
"సొ",
"భు",
"గు",
"శు",
"శ",
"ఆ",
);

my @month_names = (
"జనవరి",
"ఫిబ్రవరి",
"మార్చి",
"ఏప్రిల్",
"మే",
"జూన్",
"జూలై",
"ఆగస్టు",
"సెప్టెంబర్",
"అక్టోబర్",
"నవంబర్",
"డిసెంబర్",
);

my @month_abbreviations = (
"జనవరి",
"ఫిబ్రవరి",
"మార్చి",
"ఏప్రిల్",
"మే",
"జూన్",
"జూలై",
"ఆగస్టు",
"సెప్టెంబర్",
"అక్టోబర్",
"నవంబర్",
"డిసెంబర్",
);

my @month_narrows = (
"జ",
"ఫి",
"మ",
"ఎ",
"మె",
"జు",
"జు",
"ఆ",
"సె",
"అ",
"న",
"డి",
);

my @quarter_names = (
"ఒకటి\ \ 1",
"రెండు\ \ 2",
"మూడు\ 3",
"నాలుగు\ 4",
);

my @quarter_abbreviations = (
"Q1",
"Q2",
"Q3",
"Q4",
);

my @am_pms = (
"పూర్వాహ్నం",
"అపరాహ్నం",
);

my @era_names = (
"ఈసాపూర్వ\.",
"సన్\.",
);

my @era_abbreviations = (
"BCE",
"CE",
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
sub era_names                      { \@era_names }
sub era_abbreviations              { \@era_abbreviations }
sub full_date_format               { "\%A\ \%\{day\}\ \%B\ \%\{ce_year\}" }
sub long_date_format               { "\%\{day\}\ \%B\ \%\{ce_year\}" }
sub medium_date_format             { "\%d\-\%m\-\%\{ce_year\}" }
sub short_date_format              { "\%d\-\%m\-\%y" }
sub full_time_format               { "\%\{hour_12\}\:\%M\:\%S\ \%p\ v" }
sub long_time_format               { "\%\{hour_12\}\:\%M\:\%S\ \%p\ \%\{time_zone_long_name\}" }
sub medium_time_format             { "\%\{hour_12\}\:\%M\:\%S\ \%p" }
sub short_time_format              { "\%\{hour_12\}\:\%M\ \%p" }
sub date_before_time               { $date_before_time }
sub date_parts_order               { $date_parts_order }



1;

