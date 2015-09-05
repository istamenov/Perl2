use Test::More tests => 8;
use lib '..';
use Rules;

my $Rules = Fluxx::Engine::Rules->new;

is($Rules->Draw, 1, 'Draw test');
is($Rules->Play, 1, 'Play test');
is($Rules->HandLimit, 100, 'Hand limit test');
is($Rules->CreepersPreventYouFromWinning, 1, 'Creeper test');
is($Rules->OneTwoFive, 0, 'OneTwoFive test');
is($Rules->NoHandBonus, 0, 'HandBonus test');
is($Rules->KeeperLimit, 40, 'Keeper test');
is($Rules->GetOnWithIt, 0, 'GetOnWithIt test');

done_testing ( 8 );
