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
    diff META.YML MYMETA.yml
    mv MYMETA.yml META.yml  # or merge the two files if you don't want to loose some change in the existing META.yml
    make manifest
    make dist
    cpanspec Finance-HostedTrader-UI-*.tar.gz
    vimdiff perl-Finance-HostedTrader-UI.spec /opt/src/Finance-provisioning/build_packages/perl/specs/perl-Finance-HostedTrader-UI.spec
    mv perl-Finance-HostedTrader-UI.spec /opt/src/Finance-provisioning/build_packages/perl/specs/perl-Finance-HostedTrader-UI.spec
    mach build /opt/src/Finance-provisioning/build_packages/perl/specs/perl-Finance-HostedTrader-UI.spec
    cd /opt/src/Finance-provisioning/
    git commit -m "Updated spec file for latest version" /opt/src/Finance-provisioning/build_packages/perl/specs/perl-Finance-HostedTrader-UI.spec
    find /var/tmp/mach/fedora-16-x86_64-updates -name "*rpm" -exec scp -P guess_the_port {} joao@zonalivre.org:~/rpmbuild/RPMS/noarch/. \;
    ssh -p guess_the_port joao@zonalivre.org createrepo ~/rpmbuild/RPMS/noarch

    If mach build fails, try:
    mach clean
    cp /etc/yum.repos.d/zonalivre.repo /var/lib/mach/states/fedora-16-x86_64-updates/yum/yum.repos.d/
