use Test::More tests => 4;

use lib '..';
use Board;
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

my $Rules = Fluxx::Engine::Card->new('Name'=>'RuleN',
                                     'Type'=>'Rules',
                                     'Reference'=>'RuleRef',
                                     'Effect'=>sub{return 56;});

my $Player = Fluxx::Engine::Player->new('Name'=>'TestPlayer',
                                        'Hand'=>[$Card],
                                        'Keepers' => [$Keeper],
                                        'Creepers' => [$Creeper]);

my $Board = Fluxx::Engine::Board->new('DrawPile' => [$Creeper],
                                      'DiscardPile' =>  [$Keeper],
                                      'GoalAndRuleCards' =>  [$Rules->Name,], 
                                      'Players' => [$Player]);

is(@{$Board->DrawPile}[0]->Effect->(), 44, 'Draw pile test');
is(@{$Board->DiscardPile}[0]->Effect->(), 45, 'Discard pile test');
is(@{$Board->GoalAndRuleCards}[0], 'RuleN', 'Rule test');
is(@{$Board->Players}[0]->Name, 'TestPlayer', 'Player test');

done_testing( 4 );
