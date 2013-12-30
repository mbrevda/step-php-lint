#!/bin/sh
set -e

if [ -z "$WERCKER_PHPLINT_BUILD_PHP_DIRECTORY" ];then

    fail 'missing php_directory option, please add this to the phplint_build step in your wercker.yml'
fi

if hash php 2>/dev/null; then
	info 'php is found'
else
   	fail 'missing php executable!'
fi

find  "$WERCKER_PHPLINT_BUILD_PHP_DIRECTORY" -name \*.php | while read file; do 
	php -l $file | grep -v "No syntax errors detected" | warning; 
done 

if [[ ${PIPESTATUS[1]} -ne 0 ]]; then
 fail 'php lint-check failed';
fi

info 'completed lint-check';
