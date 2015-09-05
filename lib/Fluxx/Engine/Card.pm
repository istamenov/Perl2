#!/usr/bin/env perl

package Fluxx::Engine::Card;
#This package contains the Card class, each card corresponds to a
#real Monty Python Fluxx card
use Moose; #automatic strict and warnings

has 'Name' => (is => 'rw', isa => 'Str');
has 'Type' => (is => 'rw', isa => 'Str');
has 'Description' => (is => 'rw', isa => 'Str');
has 'Reference' => (is => 'rw', isa => 'Str');
has 'Effect' => (is => 'rw', isa => 'CodeRef');

1;
