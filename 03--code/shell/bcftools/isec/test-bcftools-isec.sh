#!/usr/bin/env bash

# define vcf files
vcf_all="/Users/leo/Documents/my-documents/02--work-and-career/02--projects--work-and-career/04--learn-and-test/02--data/bcftools/vcf_0of3_all_717L.vcf.gz"
vcf_1of3="/Users/leo/Documents/my-documents/02--work-and-career/02--projects--work-and-career/04--learn-and-test/02--data/bcftools/vcf_1of3.vcf.gz"
vcf_2of3="/Users/leo/Documents/my-documents/02--work-and-career/02--projects--work-and-career/04--learn-and-test/02--data/bcftools/vcf_2of3.vcf.gz"
vcf_3of3="/Users/leo/Documents/my-documents/02--work-and-career/02--projects--work-and-career/04--learn-and-test/02--data/bcftools/vcf_3of3.vcf.gz"

# define output dir
dir_out="/Users/leo/Documents/my-documents/02--work-and-career/02--projects--work-and-career/04--learn-and-test/04--analysis/bcftools/isec"

# intersect vcfs ################################
## all X 1 ================================
# make out dir
dir_out_0x1="$dir_out"/"out-0x1" ; mkdir "$dir_out_0x1"
# run isec
bcftools isec \
-p "$dir_out_0x1" \
"$vcf_all" \
"$vcf_1of3"

## allx1 X 2 ================================
# make out dir
dir_out_0x1x2="$dir_out"/"out-0x1x2" ; mkdir "$dir_out_0x1x2"
# define vcf_0x1
vcf_0x1="$dir_out_0x1"/"0002.vcf.gz"
# run isec
bcftools isec \
-p "$dir_out_0x1x2" \
-c none \
"$vcf_0x1" \
"$vcf_2of3"
