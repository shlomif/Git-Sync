package Git::Sync::App;

use strict;
use warnings;

use Moo;

use Git::Sync ();

sub run
{
    my $remote = shift(@ARGV)
        or die "no remote specified";

    my $branch = shift @ARGV;

    my $obj = Git::Sync->new(
        {
            remote => $remote,
            ( $branch ? ( branch => $branch ) : () ),
        }
    );

    $obj->run;

    return;
}

1;

__END__

=head1 NAME

Git::Sync::App - cmd line app to sync a git repo

=head1 SYNOPSIS

    perl -MGit::Sync::App -e 'Git::Sync::App->new->run;' -- "o" "master"

=head1 METHODS

=head2 run

Run the app
