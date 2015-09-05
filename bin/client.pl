#!/usr/bin/env perl

use IO::Socket::INET;
use IO::Select;

my $gameStarted = 0;
$|=1;
print "Welcome to Fluxx client 0.1\n";
print "1.New game\n2.Join Game\n3.Exit\n";
PROGRAM: while(my $choice = <>){
    if($choice == 1){
        if(my $pid = fork()){
            my $sock = IO::Socket::INET->new(Proto => 'tcp',
                                               LocalPort => '9001',
                                               LocalAddr => '127.0.0.1',
                                               Listen => 1,
                                               ReusePort => 1,
                                               ReuseAddr => 1) or die "bad host: $!";
            my $server = $sock->accept();
            my $addr = $server->peerhost();
            $server->autoflush(1);
            print $server "HELLO\n";
            my $operational = <$server>;
            if($operational eq "OK\n"){
                print "When you want to start the game type 'Start'\n";
                print "if you want to exit type 'Exit'\n";
            }
            my $selecter = IO::Select->new($server, STDIN);
            while(my @handles = $selecter->can_read()){
                for my $fh (@handles){
                    if($fh == $server){
                        my $response = <$fh>;
                        if($response =~ /^MESSAGE(.*)/){
                            print $1."\n";
                        }
                        elsif($response =~ /^ACTION(.*)/){
                            if($1 =~ /^PLAY(.*)/){
                                print $1."\n";
                                my $request = <>;
                                print $server join("",'PLAY',$request);
                            }
                        }
                        elsif($response =~ /^SYSTEM(.*)/){
                            if($1 =~ /^DIE/){
                                last PROGRAM;
                            }
                        }
                    }
                    elsif($fh == STDIN){
                        my $request = <>;
                        if($request eq "Start\n"){
                            print $server "START\n" unless $gameStarted;
                            $gameStarted = 1;
                        }
                        elsif($request eq "Exit\n"){
                            print $server "DIE\n";
                            waitpid $pid, 0;
                            last PROGRAM;
                        }
                        elsif(0){
                        }
                    }
                }
            }
        }
        else{
            exec '/usr/bin/env', 'perl', '/home/hadoop/lib/Fluxx/Engine/test.pl'
        }
    }
    elsif($choice == 2){
        print "Host IP address?\n";
        my $address = <>;
        my $server = IO::Socket::INET->new(Proto => 'tcp',
                                           PeerPort => 9000,
                                           PeerAddr => join("",$address),
                                           Reuse => 1)
                                           or die "unable to connect: $!";
        $server->autoflush(1);
        print "Connected to server\n";
        my $selecter = IO::Select->new($server, STDIN);
        while(my @handles = $selecter->can_read()){
            for my $fh (@handles){
                if($fh == $server){
                    my $response = <$server>;
                    if($response =~ /^MESSAGE(.*)/){
                        print $1."\n";
                    }
                    elsif($response =~ /^ACTION(.*)/){
                        if($1 =~  /^PLAY(.*)/){
                            print $1."\n";
                            my $request = <>;
                            print $server join("",'PLAY',$request);
                        }
                    }
                    elsif($response =~ /^SYSTEM(.*)/){
                        if($1 =~ /^DIE/){
                            print "Server is shutting Down\n";
                            last PROGRAM;
                        }
                    }
                }
                elsif($fh == STDIN){
                    my $request = <>;
                    if($request eq "Exit\n"){
                        print $server "EXIT\n";
                        last PROGRAM;
                    }
                    elsif(1){
                        print $request;
                    }
                }
            }
        }
    }
    elsif($choice == 3){
       print "Bye\n"; 
       last PROGRAM;
    }
    else{
        print "pick again\n";
    }
}
