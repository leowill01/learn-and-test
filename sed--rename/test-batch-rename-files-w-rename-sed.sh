# install 'rename' with homebrew
brew install rename

cd "04--analysis/03--variant-calling--postprocessing--annotation/RRM1-related/combo-varscan+mutect"

find . -type f -name "*.{all,snp,indel}*.vcf"
# find -E . -type f -regex '.+\.(all|snp|indel).+\.vcf' -print
find -E . -type f -regex '.+\.(all|snp|indel).+\.vcf'

rename -n -e 's/.all/.varscan.all/'


rename -n -e 's/.all/.varscan.all/' $(find -E . -type f -regex '.+\.(all|snp|indel).+\.vcf')

rename -e 's/.all/.varscan.all/' $(find -E . -type f -regex '.+\.(all|snp|indel).+\.vcf')
# shit, forgot to include '.snp' and '.indel' in the rename

# test
rename -n \
-e 's/.snp/.varscan.snp/' \
-e 's/.indel/.varscan.indel/' \
$(find -E . -type f -regex '.+\.(all|snp|indel).+\.vcf')

# run
rename \
-e 's/.snp/.varscan.snp/' \
-e 's/.indel/.varscan.indel/' \
$(find -E . -type f -regex '.+\.(all|snp|indel).+\.vcf')
# f***, it didn't change the files with eg '.snp.vcf'

# undo everything
# test find
find -E . -type f -regex '.+\.varscan\.(all|snp|indel).+\.vcf' | wc -l # 740 same as when first calculated - doesnt includeeg '.snp.vcf'
# remove all '.varscan'
# rename -n \
rename \
-e 's/\.varscan//' \
$(find -E . -type f -regex '.+\.varscan\.(all|snp|indel).+\.vcf')
# rename to add '.varscan' including files with nothing in between var type and extension eg '.snp.vcf'
# test number of files with fixed '*' regex operator - should be more than 740
find -E . -type f -regex '.+\.(all|snp|indel).*\.vcf' | wc -l # 851
# run
# rename -n \
rename \
-e 's/\.all/\.varscan\.all/' \
-e 's/\.snp/\.varscan\.snp/' \
-e 's/\.indel/\.varscan\.indel/' \
$(find -E . -type f -regex '.+\.(all|snp|indel).*\.vcf')