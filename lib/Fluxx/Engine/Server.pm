#!/usr/bin/env perl
use lib '../lib';

package Fluxx::Engine::Server; 
use Moose;#automatic strict and warnings 
use Fluxx::Engine::Board;
use Fluxx::Engine::Player;
use Fluxx::Engine::Rules;
use IO::Socket::INET;
use IO::Select;
use Scalar::Util;

sub run{
    $| =1;
    my $shutDown = 0;
    my @clients;
    my $serverInstance = shift;
    my $host = IO::Socket::INET->new(Proto => 'tcp',
                                       PeerPort => 9001,
                                       ReuseAddr => 1,
                                       PeerAddr => '127.0.0.1',
                                       ReusePort => 1)
                                       or die "unable to connect: $!";
    $host->autoflush(1);
    my $server = IO::Socket::INET->new(Proto => 'tcp',
                                       LocalPort => 9000,
                                       Listen => SOMAXCONN,
                                       ReusePort => 1,
                                       ReuseAddr => 1)or die "bad socket: $!";
    my $selecter = IO::Select->new($server, $host);
INIT:while(my @handles = $selecter->can_read()){
        for my $fh (@handles){
            if($fh == $host){
                my $command = <$host>;
                if($command eq "HELLO\n"){
                    print $host "OK\n";
                }
                elsif($command eq "START\n"){
                    push  @clients, $host;
                    for my $client (@clients){
                        print $client "MESSAGEBeginning game\n";
                    }
                    last INIT;
                }	
                elsif($command eq "DIE\n"){
                    for my $client (@clients){
                        print $client "SYSTEMDIE\n";
                    }
                    $shutDown = 1;
                    last INIT;
                }
                else{
                    print $command;
                }
            }
            elsif($fh == $server){
                my $client = $fh->accept();
                $client->autoflush(1);
                print $client "MESSAGEWelcome, to Fluxx 0.1\n";
                print $host "MESSAGE". $client->sockhost(). " has joined the game\n";
                for my $cl (@clients){
                    print $cl "MESSAGE". $client->sockhost(). " has joined the game!\n";
                }
                push @clients, $client;
                $selecter->add($client);
            }
            else{
                my $command = <$fh>;
                if($command =~ /^EXIT/){
                     for(my $i =0; $i< $#clients+1; ++$i){
                         if ($clients[$i] == $fh){
                             $selecter->remove($fh);
                             print "Closing ".$fh->sockport();
                             close $fh;
                             splice @clients, $i, 1;
                             last;
                         }
                     }
                }
            }
        }
    }
    while(not $shutDown){
        my $rules = Fuxx::Engine::Rules->new();
        for my $client (@clients){
            print $client "MESSAGEThe game has started!\n";
            print $client "SYSTEMDIE\n";
        }
        #game logic here!
    }
}

1;
