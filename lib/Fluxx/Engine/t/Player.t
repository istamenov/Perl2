use Test::More tests => 4;
use lib '..';
use Player;
use Card;

my $Card = Fluxx::Engine::Card->new('Name'=>'TestCardN',
                                    'Type'=>'TestCardT',
                                    'Reference'=>'TestCardR',
                                    'Description'=>'TestCardD',
                                    'Effect'=>sub{return 43;});

my $Creeper = Fluxx::Engine::Card->new('Name'=>'TestCreeperN',
                                    'Type'=>'TestCreeperT',
                                    'Reference'=>'TestCreeperR',
                                    'Description'=>'TestCreeperD',
                                    'Effect'=>sub{return 44;});

my $Keeper = Fluxx::Engine::Card->new('Name'=>'TestKeeperN',
                                    'Type'=>'TestKeeperT',
                                    'Reference'=>'TestKeeperR',
                                    'Description'=>'TestKeeperD',
                                    'Effect'=>sub{return 45;});

my $Player = Fluxx::Engine::Player->new('Name'=>'TestPlayer',
                                        'Hand'=>[$Card],
                                        'Keepers' => [$Keeper],
                                        'Creepers' => [$Creeper]);

is(@{$Player->Hand}[0]->Name, 'TestCardN', 'Hand card name test');
is($Player->Name, 'TestPlayer', 'Player name test');
is(@{$Player->Keepers}[0]->Name, 'TestKeeperN', 'Keeper card name test');
is(@{$Player->Creepers}[0]->Name, 'TestCreeperN', 'Creeper card name test');


done_testing( 4 );
