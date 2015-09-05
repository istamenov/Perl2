#!/usr/bin/env perl

package Fluxx::Engine::Rules;
#this package defines the Rules set that is available for the game
use Moose;#use strict, use warnings by default
use Moose::Util::TypeConstraints;

subtype 'PosInt',
    as 'Int',
    where {$_ > 0},
    message {'You need a positive integer' };

has 'HandLimit' => (is => 'rw', isa => 'PosInt', required => 0, default => 100);
has 'Play' => (is => 'rw', isa => 'PosInt', required => 0, default => 1);
has 'Draw' => (is => 'rw', isa => 'PosInt', required => 0, default => 1);
has 'CreepersPreventYouFromWinning' => (is => 'rw', isa => 'Bool', 
                                        required => 0, default => 1);
has 'OneTwoFive' => (is => 'rw', isa => 'Bool', required => 0, default => 0);
has 'NoHandBonus' => (is => 'rw', isa => 'Bool', required => 0, default => 0);
has 'KeeperLimit' => (is => 'rw', isa => 'PosInt', required => 0, default => 40);
has 'GetOnWithIt' => (is => 'rw', isa => 'Bool', required => 0, default => 0);

1;
