package charm;

use Mojo::Base -role, -signatures;
use FindBin;
use lib "$FindBin::Bin/..lib";
use Module::Runtime qw(use_package_optimistically);
use Capture::Tiny 'capture';
use base "Exporter::Tiny";
our @EXPORT = qw(sh plugin config resource unit status pkg);

sub sh ( $cmd, $args ) {
    my ( $out, $err, $exit_code ) = capture {
        system $cmd, $args;
    };
    return {
        out       => $out,
        err       => $err,
        exit_code => $exit_code
    };
}

sub pkg ( $pkgs = [], $ensure = "install" ) {
    my $install_args = [ "apt", "-qyf" ];
    push @{$install_args}, $ensure;
    push @{$install_args}, $pkgs;
    sh(
        "apt", $install_args
    );
}

sub plugin ( $name, $opts = {} ) {
    return use_package_optimistically("$name")->new($opts);
}

sub config ($key) {

    return sh "config-get", $key;
}

sub resource ($key) {

    return sh "resource-get", $key;
}

sub unit ($key) {

    return sh "unit-get", $key;
}

sub status ( $opts = {} ) {
    die "Needs a 'level' and 'msg'"
      unless ( exists $opts->{level} && exists $opts->{msg} );
    sh "status-set", $opts->{level}, $opts->{msg};
}

1;
