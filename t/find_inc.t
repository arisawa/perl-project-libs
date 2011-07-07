use strict;
use warnings;
use FindBin;
use File::Spec;
use Test::More;
use Config;
use Project::Libs;

subtest 'find_inc' => sub {
    my @submodules = Project::Libs::find_inc($FindBin::Bin, [qw(extlib)], [], ());
    is_deeply \@submodules, [
        File::Spec->catfile($FindBin::Bin, 'extlib'),
        File::Spec->catfile($FindBin::Bin, 'modules/Plack/lib'),
        File::Spec->catfile($FindBin::Bin, 'modules/Devel-KYTProf/lib'),
    ];
    done_testing;
};

subtest 'find_inc for local::lib' => sub {
    my @submodules = Project::Libs::find_inc($FindBin::Bin, [], 'locallib', ());
    is_deeply \@submodules, [
        File::Spec->catfile($FindBin::Bin, 'locallib/lib/perl5'),
        File::Spec->catfile($FindBin::Bin, "locallib/lib/perl5/$Config{archname}"),
        File::Spec->catfile($FindBin::Bin, 'modules/Plack/lib'),
        File::Spec->catfile($FindBin::Bin, 'modules/Devel-KYTProf/lib'),
    ];
    done_testing;
};

my $gitmodules = "$FindBin::Bin/.gitmodules";

subtest 'find_git_submodules' => sub {
    my @submodules = Project::Libs::find_git_submodules(
        $FindBin::Bin,
        File::Spec->catfile($FindBin::Bin, '.gitmodules'),
    );
    is_deeply \@submodules, [
        File::Spec->catfile($FindBin::Bin, 'modules/Plack/lib'),
        File::Spec->catfile($FindBin::Bin, 'modules/Devel-KYTProf/lib'),
    ];
    done_testing;
};

done_testing;
