#!/bin/sh

find ./ttemplates -name *.tt -exec xmllint --noout {} \;
