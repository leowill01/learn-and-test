#!/usr/bin/env bash

# CASE STATEMENT
variable="hello there"

case "$variable" in
	"hello")	echo "The \$variable says 'hello'" ;;
	"hello there")	echo "The \$variable says 'hello there'" ;;
esac
