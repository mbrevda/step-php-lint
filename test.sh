#!/bin/bash
#PS4='+($?) $BASH_SOURCE:$FUNCNAME:$LINENO:'

#test script to mimic fail/warning/info handlers for wercker locally

export WERCKER_PHP_LINT_DIRECTORY="./"
GENERATED_BUILD_NR="1"

. build-esen.sh

. run.sh

RESULT=$?
if [[ $RESULT -ne "0" ]] || [[ $GENERATED_BUILD_NR != "1" ]]; then
    echo "Test: FAIL -> $RESULT"
    return 1 2>/dev/null || exit 1
else
	echo "done"
fi
