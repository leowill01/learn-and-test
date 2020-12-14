#!/usr/bin/env bash

# test example on how to pass an arbitrary number of arguments to a function. this is useful in order to not have to run the function in a for loop

myecho () {
	for arg in "$@"; do
		echo "$arg"
	done
}

myecho 9Lu_T-717L_N.all.Germline.hc.vcf
myecho *.Germline.hc.vcf
myecho *.hc.vcf
myecho *.vcf
myecho *