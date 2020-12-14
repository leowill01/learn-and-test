#!/usr/bin/env bash

cd "/Users/leo/Desktop/work--tmp/7444E_T-717L_N/varscan/results--2020-12-08-210857--vaf_0.05-cov_10"

# # DEFINITIONS ################
# ## FUNCTIONS ========
# 	# compress and index an arbitrary number of vcfs
# 	compressAndIndexVCF () {
# 		for vcf in "$@"; do
# 			bgzip -c "$vcf" > "${vcf}.gz"
# 			tabix "${vcf}.gz"
# 		done
# 	}

# 	# count all variants in vcfs
# 	countVariants () {
# 		for vcf in "$@"; do
# 			variant_count=$(grep '^[^#]' "$vcf" | wc -l)
# 			echo -e "$vcf\t$variant_count"
# 		done
# 	}



# # TEST COMPRESS, INDEX, AND COMBINE

# 	# compress and index all vcfs
# 	compressAndIndexVCF *.vcf

	# for every "snp" vcf.gz in the results dir,
	for snp_vcfgz in *.snp*.vcf.gz; do
		# print which file is being used
		echo "\n\nUsing SNP vcf.gz file: $snp_vcfgz"

		# define filename for output .all*.vcf file
		out_all_vcfgz=$(echo "$snp_vcfgz" | sed 's/snp/all/') # replace 'snp' with 'all'
		out_all_vcf="${out_all_vcfgz%.gz}" # remove .gz from out filename
		# print out filename
		echo "Out all VCF: $out_all_vcf"

		# create string to search for a matching 'indel' file
		matching_indel_vcfgz=$(echo $snp_vcfgz | sed 's/snp/indel/')
		echo "Searching for indel file: $matching_indel_vcfgz"

		# if the matching indel file exists,
		if [[ -f "$matching_indel_vcfgz" ]]; then
			# merge the files into an .all file containing both the SNP and INDEL variants
			echo "Merging $snp_vcfgz $matching_indel_vcfgz"
			bcftools concat \
			--allow-overlaps \
			--rm-dups none \
			"$snp_vcfgz" "$matching_indel_vcfgz" > "$out_all_vcf"
		fi
			
		# if the snp file is the .hc.filter.vcf with no matching indel file,
		if [[ "$snp_vcfgz" == *".snp.Somatic.hc.filter.vcf.gz" ]]; then
			#  merge it with the indel file matching the non-indel-filtered .snp.Somatic.hc.vcf (i.e., '.indel.Somatic.hc.vcf.gz') because it's required that that indel file exists in order for the .hc.filter.vcf file to be made since the .snp.Somatic.hc.filter.vcf file is made from it
			filter_indel_vcfgz=$(echo *.indel.Somatic.hc.vcf.gz)
			
			echo "Merging $snp_vcfgz $filter_indel_vcfgz"
			bcftools concat \
			--allow-overlaps \
			--rm-dups none \
			"$snp_vcfgz" "$filter_indel_vcfgz" > "$out_all_vcf"
		fi
	done

	# rm all gz and tbi files
	rm *.vcf.gz *.vcf.gz.tbi

	# count variants in the resulting VCF files to check if numbers are correct
	countVariants *.vcf > variant-counts.tsv

# ################ DONE TESTING ################

	echo2 () {
		# args="$@"
		echo "name of arg $@"
	}

	vcf="9Lu_T-717L_N.snp.Somatic.hc.filter.vcf"
	if [[ "$vcf" == *.snp.Somatic.hc.filter.vcf ]]
	then
		echo "TRUE"
	else
		echo "FALSE"
	fi
