# use AWK to extract tab separated values
cd "/Volumes/Pursell-Lab-HD/Pursell-lab/02--projects/project_02--DNA-seq-analysis/04--analysis/03--variant-calling--postprocessing--annotation/RRM1-related/RRM1MutMice--Chabes/mutect"

file="tumor-normal-table.tsv"

# test basic awk command
awk '
{ print $1 }
' "$file"

# incorp awk command into while loop
# echo file without the header line
tail -n +2 "$file" | \
while read line; do
	# print entire line
	# echo "$line"

	# assign 1st col value to var
	sample_name=$(echo "$line" | cut -d '\t' -f 1)
	# col1=$( awk '{ print $1 }' "$line" )
	# print value for col1
	echo "Sample name: $sample_name"

done
# done < $( tail -n +2 "$file" ) # remove 1st line of input file

tail -n +2 $file | head -n 3