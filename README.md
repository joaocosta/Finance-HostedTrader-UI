Run script/finance_hostedtrader_ui_server.pl to test the application.





CONTROLLER:
    script/finance_hostedtrader_ui_create.pl controller Signal
    script/finance_hostedtrader_ui_create.pl controller Chart


MODEL:
# This model is not currently used
    script/finance_hostedtrader_ui_create.pl model DB DBIC::Schema Finance::HostedTrader::UI::Schema create=static dbi:mysql:fx 'fxhistor' '' '{ AutoCommit => 1 }'


VIEW:
    script/finance_hostedtrader_ui_create.pl view TT TT
    script/finance_hostedtrader_ui_create.pl view chart TT

To run a development version:
    script/finance_hostedtrader_ui_server.pl -r

To cut a distribution:
    vi lib/Finance/HostedTrader/UI.pm # update version number
    git commit -m "update version number for new release" lib/Finance/HostedTrader/UI.pm
    git st # Make sure it's clean
    perl Makefile.PL
    rm MYMETA.json
    diff META.yml MYMETA.yml
    mv MYMETA.yml META.yml  # or merge the two files if you don't want to loose some change in the existing META.yml
    make manifest
    make dist
    cpanspec Finance-HostedTrader-UI-*.tar.gz
    cp Finance-HostedTrader-UI-*.tar.gz ~/rpmbuild/SOURCES/.
    vimdiff perl-Finance-HostedTrader-UI.spec spec/perl-Finance-HostedTrader-UI.spec
    rm perl-Finance-HostedTrader-UI.spec
    cp spec/perl-Finance-HostedTrader-UI.spec ~/.
    rpmbuild -bs ~/perl-Finance-HostedTrader-UI.spec
    mock rebuild --no-clean ~/rpmbuild/SRPMS/perl-Finance-HostedTrader-UI*
    git commit -m "Updated spec file for latest version" spec/perl-Finance-HostedTrader-UI.spec
    scp -P $PORT /var/lib/mock/fedora-20-x86_64/result/*rpm joao@zonalivre.org:~/rpmbuild/RPMS/noarch/.
    ssh -p $PORT joao@zonalivre.org createrepo ~/rpmbuild/RPMS/noarch
