#!/bin/bash

#test script to mimic fail/warning/info handlers for wercker locally

export WERCKER_PHPLINT_BUILD_DIRECTORY="./"

function info {
	echo "info: $1"
}

function warning {
	echo "warning: $1"
}

function fail {
	echo "Failing with: $1"
	exit 1;
}

source "./run.sh"

RESULT=$?
if [[ $? != "0" ]] || [[ $GENERATED_BUILD_NR != "1" ]]; then
    echo "Test: FAIL -> $RESULT"
    return 1 2>/dev/null || exit 1
else
	echo "done"
fi
