#!/bin/sh
set -e

if [ -z "$WERCKER_PHPLINT_BUILD_DIRECTORY" ]
then
    fail 'missing directory option, please add this the rsync-deploy step in wercker.yml'
fi

if hash php 2>/dev/null; then
	info 'php is found'
else
   	fail 'missing php executable!'
fi


RESULT=$(find  "$WERCKER_PHPLINT_BUILD_DIRECTORY" -name \*.php -exec echo  php {} \;)
if [[ $RESULT != "0" ]] 
 warning $RESULT;
 fail 'php lint-check failed';
fi

info 'completed lint-check';