package Git::Sync;

use strict;
use warnings;

use Moo;

has 'remote' => ( is => 'ro', required => 1, );
has 'branch' => ( is => 'ro', default  => 'master', );

my %aliases = (
    'o'  => 'origin',
    'u'  => 'upstream',
    'gh' => 'github',
    'b'  => 'bitbucket'
);

sub _remote_aliases
{
    return \%aliases;
}

sub run
{
    my $self = shift;

    my $aliases = $self->_remote_aliases;

    my $remote = $self->remote;
    if ( exists $aliases->{$remote} )
    {
        $remote = $aliases->{$remote};
    }
    my $branch = $self->branch;

    my $ret = system(
qq#git pull --ff-only "$remote" "$branch" && git fetch "$remote" && git fetch "$remote" --tags#
    );

    if ($ret)
    {
        die $!;
    }
    return;
}

1;

__END__

=head1 NAME

Git::Sync - synchronize a git repository.

=head1 METHODS

=head2 my $branch = $self->branch;

Returns the git branch.

=head2 my $remote = $self->remote;

Returns the git remote.

=head2 $self->run;

Runs the git commands.

=cut
