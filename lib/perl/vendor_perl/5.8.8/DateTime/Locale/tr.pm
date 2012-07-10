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
# This file was generated from the source file tr.xml.
# The source file version number was 1.91, generated on
# 2007/07/26 04:29:36.
#
# Do not edit this file directly.
#
###########################################################################

package DateTime::Locale::tr;

use strict;

BEGIN
{
    if ( $] >= 5.006 )
    {
        require utf8; utf8->import;
    }
}

use DateTime::Locale::root;

@DateTime::Locale::tr::ISA = qw(DateTime::Locale::root);

my @day_names = (
"Pazartesi",
"Salı",
"Çarşamba",
"Perşembe",
"Cuma",
"Cumartesi",
"Pazar",
);

my @day_abbreviations = (
"Pzt",
"Sal",
"Çar",
"Per",
"Cum",
"Cts",
"Paz",
);

my @day_narrows = (
"P",
"S",
"Ç",
"P",
"C",
"C",
"P",
);

my @month_names = (
"Ocak",
"Şubat",
"Mart",
"Nisan",
"Mayıs",
"Haziran",
"Temmuz",
"Ağustos",
"Eylül",
"Ekim",
"Kasım",
"Aralık",
);

my @month_abbreviations = (
"Oca",
"Þub",
"Mar",
"Nis",
"May",
"Haz",
"Tem",
"Aðu",
"Eyl",
"Eki",
"Kas",
"Ara",
);

my @month_narrows = (
"O",
"Ş",
"M",
"N",
"M",
"H",
"T",
"A",
"E",
"E",
"K",
"A",
);

my @quarter_names = (
"1\.\ çeyrek",
"2\.\ çeyrek",
"3\.\ çeyrek",
"4\.\ çeyrek",
);

my @quarter_abbreviations = (
"Ç1",
"Ç2",
"Ç3",
"Ç4",
);

my @am_pms = (
"AM",
"PM",
);

my @era_names = (
"BCE",
"CE",
);

my @era_abbreviations = (
"MÖ",
"MS",
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
sub full_date_format               { "\%d\ \%B\ \%\{ce_year\}\ \%A" }
sub long_date_format               { "\%\{day\}\ \%B\ \%\{ce_year\}" }
sub medium_date_format             { "\%d\.\%b\.\%\{ce_year\}" }
sub short_date_format              { "\%d\.\%m\.\%\{ce_year\}" }
sub full_time_format               { "\%H\:\%M\:\%S\ v" }
sub long_time_format               { "\%H\:\%M\:\%S\ \%\{time_zone_long_name\}" }
sub medium_time_format             { "\%H\:\%M\:\%S" }
sub short_time_format              { "\%H\:\%M" }
sub date_before_time               { $date_before_time }
sub date_parts_order               { $date_parts_order }



1;

