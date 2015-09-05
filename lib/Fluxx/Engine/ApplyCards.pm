#!/usr/bin/env perl
use lib '../..';
use Card;
use Deck;
use List::Util qw/shuffle/;
use strict;
use warnings;
my @shuffledCards = shuffle @main::cards;
my $first = shift @shuffledCards;
my $second = shift @shuffledCards;
my $third = shift @shuffledCards;
my $fourth = shift @shuffledCards;
my $fifth = shift @shuffledCards;
my $sixth = shift @shuffledCards;
my $rules = Fluxx::Engine::Rules->new();
my $player1 = Fluxx::Engine::Player->new(Name => "p1", Hand => 
[splice (@shuffledCards, 0, 3)], Keepers => [], Creepers => []);
my $player2 = Fluxx::Engine::Player->new(Name => "p2", Hand => 
[splice (@shuffledCards, 0, 3)], Keepers => [], Creepers => []);
my $board = Fluxx::Engine::Board->new(DrawPile => \@shuffledCards, DiscardPile =>
[], GoalAndRulesCards => [], Player1 => $player1, Player2 => $player2,
CurrentPlayer => 'Player1');

my $engine = Fluxx::Engine::Engine->new(Rules => $rules,Board => $board);

