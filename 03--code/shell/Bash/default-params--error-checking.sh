#!/usr/bin/env bash

min_vaf="0.05"
echo $(echo "$min_vaf")
echo "Minimum VAF value 1 is set to: $min_vaf"

min_vaf2=${1:-"0.05"}
# check if value is in the correct range
if [[ $min_vaf2 > 0.2 ]]; then
	echo "Minimum VAF value 2 is greater than 0.2 (20%). Please run with a lower value." 1>&2
	exit 1
fi

echo "Minimum VAF value 2 is set to: $min_vaf2"
echo "Program finished successfully"
