#!/bin/bash 
set +e

if [ -z "$WERCKER_PHP_LINT_DIRECTORY" ];then
    fail 'missing "directory" option, please add this to the php-lint step in your wercker.yml'
fi

if hash php 2>/dev/null; then
	info "PHP found"
else
   	fail "PHP not found!"
fi


ERR=0
LINE=0
O=""
while IFS= read -r -d '' file; do
    LINE=$(($LINE + 1))
    if (($LINE % 80 == 0 )); then
        echo  .
    else
        echo -n .
    fi
    #php -l "$file" | grep -v "No syntax errors detected"; 
    O+=$({ php -l bad.php > /dev/null;  } 2>&1 | tee)\\n
    (( ERR |= ${PIPESTATUS[0]}  ))
done < <(find "$WERCKER_PHP_LINT_DIRECTORY" -name \*.php -print0)
echo

echo -e $O
if [[ $ERR -ne "0" ]]; then
    fail "PHP lint failed";
else 
    success "PHP lint  completed successfully";
fi

