#!/usr/bin/env bash

# How do you distinguish a positional parameter (e.g. "$1") passed to the script from the command line vs "$1" passed to a function inside the script?

# CLI args:
cli_arg_1="$1"
func_arg_1="$2"

echo "1st CLI arg is: $cli_arg_1"
echo "2nd CLI arg is: $func_arg_1"

# define function
myFunction () {
	echo "1st function arg is: $1"
}

myFunction "$func_arg_1"
# Ok, so it seems like the scope of positional arguments change depending on what they are passed to. e.g. if passed to script from CLI, then they act there; if passed to a function inside a script, then they act there
