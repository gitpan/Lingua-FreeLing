use strict;
use warnings;

use Carp;
use lib 'inc';
use MyBuilder;

use File::Spec::Functions qw'catfile catdir rootdir';

my $builder = MyBuilder->new
  (
   module_name    => 'Lingua::FreeLing',
   license        => 'perl',
   dist_author    => ['Jorge Cunha Mendes <jorgecunhamendes@gmail.com>',
                      'Alberto Simões <ambs@cpan.org>'],
   needs_compiler => 1,
   recursive_test_files => 1,
   configure_requires => { 'Module::Build' => '0.36' },
   build_requires => {
                      'Test::Warn' => '0',
                     },
   requires => {
                'Try::Tiny' => '0',
                'Carp' => '0',
               },
   add_to_cleanup => [
                      'FreeLing.o', 'pm_to_blib',
                      qw'*~ */*~ */*/*~ */*/*/*~ */*/*/*/*~'
                     ],
  );

$builder->config_data("foo" => "bar");


# Detect where freeling has language files
my $R = rootdir();
my @common_prefixes = (catdir($R => 'usr'),
                       catdir($R => 'usr' => 'local'),
                       catdir($R => 'opt' => 'local'),
                       catdir($R => 'sw'));
my $prefix = undef;
if ($ENV{FL_PREFIX}) {
    $prefix = $ENV{FL_PREFIX} if -d catdir($ENV{FL_PREFIX} => 'share' => 'FreeLing' => 'common');
} else {
    for my $p (@common_prefixes) {
        ($prefix = $p) and last if -d catdir($p => 'share' => 'FreeLing' => 'common');
    }
}

if (!$prefix) {
    carp "Could not find FreeLing or FreeLing data dir.\n";
    exit 0;
}
$builder->config_data(prefix => $prefix);

$builder->create_build_script;


