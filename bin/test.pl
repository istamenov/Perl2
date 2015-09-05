#!/usr/bin/env perl
use v5.18;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Fluxx::Engine::Card;
use Fluxx::Engine::Player;
my $Card = Fluxx::Engine::Card->new('Name' => 'Test', 
                                     'Type' => 'Test',
                                     'Description' => 'Test',
                                     'Reference' => 'Test',
                                     'Effect' => sub{ my $player = shift;say $player->Name("gg");});
my $Player = Fluxx::Engine::Player->new('Name' => 'TestPN',
                                        'Hand' => [$Card ],
                                        'Keepers' => [],
                                        'Creepers' => []);
say $Player->Name;
$Card->Effect->($Player);
say $Player->Name;
say @{$Player->Hand}[0]->Name;


use Fluxx::Engine::Rules;

my $Rules = Fluxx::Engine::Rules->new;

say $Rules->HandLimit;

my $Board = Fluxx::Engine::Rules->new('DrawPile' => [],
                                      'DiscardPile' => [],
                                      'GoalAndRUlesCards' => [],
                                      'Players' => [$Player]);
