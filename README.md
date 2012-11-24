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


To cut a distribution:
    git st # Make sure it's clean
    perl Makefile.PL
    rm MYMETA.json
    git META.YML MYMETA.yml
    mv MYMETA.yml META.yml  # or merge the two files if you don't want to loose some change in the existing META.yml
    make manifest
    make dist
