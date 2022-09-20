#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Setup
echo "What list do you want to correct?"
read LIST
if [[ $LIST != C* ]]
then
	echo "Please enter a valid list name, ex: C00, C01, C02, C03, C04, C05, C06"
	exit 1
fi

git clone https://github.com/LucasKuhn/joaonette.git
# Check every exercise
for DIR in ex* ; do
	echo "====== $DIR ======"
	ERROR=""
	mv joaonette/$LIST/$DIR/main.c $DIR/main.c 
	mv joaonette/$LIST/$DIR/expected_output $DIR/expected_output
	cc -Wall -Wextra -Werror -lbsd  $DIR/*.c -o $DIR/a.out
	./$DIR/a.out > $DIR/user_output
	DIFF=$(diff $DIR/user_output $DIR/expected_output)
	rm $DIR/a.out
	if [[ "$DIFF" == "" ]]; then
		echo -e "OK ${GREEN}✓${NC}"
	else
		echo -e "KO ${RED}✖${NC}"
	fi
done
rm -rf joaonette