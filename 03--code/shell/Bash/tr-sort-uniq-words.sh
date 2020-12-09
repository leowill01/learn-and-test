#!/usr/bin/env bash

input_phrase=$1

echo "$1" | \
tr -d '.' | \
tr -d ',' | \
tr ' ' '\n' | \
sort | \
uniq | \
tr '\n' ' '