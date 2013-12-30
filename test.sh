#!/bin/bash

#test script to mimic fail/warning/info handlers for wercker locally

export WERCKER_PHP_LINT_DIRECTORY="./"
GENERATED_BUILD_NR="1"

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

. run.sh

RESULT=$?
if [[ $RESULT -ne "0" ]] || [[ $GENERATED_BUILD_NR != "1" ]]; then
    echo "Test: FAIL -> $RESULT"
    return 1 2>/dev/null || exit 1
else
	echo "done"
fi
echo 'here'
