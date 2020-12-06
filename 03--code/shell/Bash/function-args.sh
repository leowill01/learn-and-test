#!/usr/bin/env bash
# test - passing arguments to bash functions

# define function
myFunction () {
	echo "The first argument is: $1" # arguments are referred to positionally
	echo "The second argument is: $2"
}

# call function
myFunction "FIRST\!" "SECOND\!"

# what if it's missing the second-position argument? ('$2')
myFunction "FIRST\!" 
	# > myFunction "FIRST\!"
	# The first argument is: FIRST!
	# The second argument is: 
# A: it simply doesnt print

# define new function to conditionally act if a 2nd arg isnt present
myFunction2 () {
	echo "The first argument is: $1"

	# if string length of 2nd argument is non-zero, run command
	if [[ -n "$2" ]]; then
		echo "The second argument is: $2"
	else
		echo "2nd arg is unset"
	fi
}

myFunction2 "FIRST"
myFunction2 "FIRST" "And this is the second argument."
myFunction2 "FIRST" "" # what if 2nd arg is empty string? same as first call bc string length is not >0

arg1="THE ARGUMENT EXISTS"

if [[ -n "$arg1" ]]; then
	echo "$arg1"
else
	echo "Doesnt exist"
fi