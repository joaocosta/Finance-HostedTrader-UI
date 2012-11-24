#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install;

name 'Finance-HostedTrader-UI';
all_from 'lib/Finance/HostedTrader/UI.pm';

configure_requires 'CPAN';
configure_requires 'File::Copy::Recursive';
requires 'Catalyst::Runtime' => '5.80013';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires 'Catalyst::View::TT' => 0;
requires 'Catalyst::Model::DBIC::Schema' => 0;

requires 'Finance::HostedTrader';
requires 'JSON';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
