#!/bin/bash
if [ -z "$WERCKER_PHP_LINT_DIRECTORY" ];then

    fail 'missing php_directory option, please add this to the php_lint step in your wercker.yml'
fi

if hash php 2>/dev/null; then
	info 'php is found'
else
   	fail 'missing php executable!'
fi


ERR=0
while IFS= read -r -d '' file; do
    php -l "$file" | grep -v "No syntax errors detected"; 
    (( ERR |= ${PIPESTATUS[0]}  ))
done < <(find "$WERCKER_PHP_LINT_DIRECTORY" -name \*.php -print0)

if [[ $ERR -ne "0" ]]; then
    fail 'PHP lint check failed';
fi

info 'PHP lint check complete';

