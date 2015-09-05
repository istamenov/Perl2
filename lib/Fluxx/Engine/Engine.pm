#!/usr/bin/env perl

package Fluxx::Engine::Engine;
#the package defines the Fluxx Engine
use Moose;
use IO::Socket;
use Fluxx::Engine::Rules;
use Fluxx::Engine::Board;

has 'Board' => (is => 'rw', isa => 'Fluxx::Engine::Board', required => 1);
has 'Rules' => (is => 'rw', isa => 'Fluxx::Engine::Rules', required => 1);
#has 'Sockets' => (is => 'rw', isa => 'HashRef[IO::Socket::INET]', required => 1);


sub run{
    my $engineInstance = shift;
    while(1){
        if($engineInstance->Board->CurrentPlayer eq 'Player1'){
             print $Sockets{'Player1') 'ACTIONPLAY';
             my $play = <$Sockets{'Player1'}>;
        }
        elsif($engineInstance->Board->CurrentPlayer eq 'Player2'){
             print $Sockets{'Player2') 'ACTIONPLAY';
             my $play = <$Sockets{'Player2'}>;
             if $play
        }
}

1;
