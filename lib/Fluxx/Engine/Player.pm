#!/usr/bin/env perl

package Fluxx::Engine::Player;
#the package defines a Player as the Fluxx Engine will see it
use Moose; #use strict, use warnings are default
use Moose::Util::TypeConstraints;

has 'Name' => (is => 'rw', isa => 'Str', required => 1);
has 'Hand' => (is => 'rw', isa => 'ArrayRef[Fluxx::Engine::Card]', required => 1);
has 'Keepers' => (is => 'rw', isa => 'ArrayRef[Fluxx::Engine::Card]', required => 1);
has 'Creepers' => (is => 'rw', isa => 'ArrayRef[Fluxx::Engine::Card]', required => 1);
has 'HasExcalibur' => (is => 'rw', isa => 'Bool', default => 0, required => 0);
has 'HasCatapult' => (is => 'rw', isa => 'Bool', default => 0, required => 0);
has 'HasGrenade' => (is => 'rw', isa => 'Bool', default => 0, required => 0);
has 'HasFinger' => (is => 'rw', isa => 'Bool', default => 0, required => 0);

1;
