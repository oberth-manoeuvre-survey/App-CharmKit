requires 'Mock::Sub'             => '1.09';
requires 'Import::Into'          => '1.002005';
requires 'Path::Tiny'            => '0.108';
requires 'boolean'               => '0.46';
requires 'true'                  => '0.18';
requires 'Smart::Comments'       => '1.06';
requires "Test::More"            => "1.302133";
requires 'bareword::filehandles' => '0.006';
requires 'Sub::Install'          => '0.928';
requires 'Module::Runtime'       => '0.016';
requires "Mojolicious"           => '8.20';
requires "Role::Tiny"            => '2.000006';

on 'test' => sub {
  requires "Test::More" => "0";
};
