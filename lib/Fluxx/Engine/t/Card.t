
use Test::More tests => 5;
use lib '..';
use Card;

my $Card = Fluxx::Engine::Card->new('Name'=>'TestN',
                                    'Type'=>'TestT',
                                    'Reference'=>'TestR',
                                    'Description'=>'TestD',
                                    'Effect'=>sub{return 43;});
is($Card->Name,'TestN', 'Name Test');
is($Card->Type,'TestT', 'Type Test');
is($Card->Reference,'TestR', 'Ref Test');
is($Card->Description,'TestD', 'Desc Test');
is($Card->Effect->(),43,'Effect Test');

done_testing( 5 );
