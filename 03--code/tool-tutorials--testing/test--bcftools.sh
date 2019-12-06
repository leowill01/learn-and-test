#!/usr/local/bin/bash

pwd # should default to project directory

VCF="02--data/m079-tn-WES.snp.Somatic.hc.filter/m079-tn-WES.snp.Somatic.hc.filter.mm10_multianno.vcf"
printf "$VCF"

bcftools view -H $VCF | head

bcftools query -H \
-f '%CHROM\t%POS\t%REF\t%ALT[\t%FREQ]\n' \
$VCF | head

bcftools query \
-f '%CHROM\t%POS\t%REF\t%ALT[\t%DP\t%RD\t%AD\t%FREQ\t%DP4]\n' \
-e 'DP4[0:2] > 0 || DP4[0:3] > 0' \
-e 'DP4[1:2] = 0 || DP4[1:3] = 0' \
$VCF | head

bcftools view -H \
-e 'FORMAT/DP[0] < 100' \
-e 'DP4[0:2]>0 | DP4[0:3]>0' \
-e 'DP4[1:2]=0 || DP4[1:3]=0' \
$VCF | head -n 30
