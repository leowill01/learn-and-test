#' ---
#' title: 'Learn: vcfR'
#' subtitle: 'From: vcfR Documentation'
#' output:
#'   html_notebook:
#'     toc: yes
#'     toc_float: yes
#'   pdf_document:
#'     toc: yes
#' ---
#' 
#' These tutorials are based on the official `vcfR` tutorials from the [vcfR documentation](https://knausb.github.io/vcfR_documentation/index.html)
#' 
#' # Setup
#' 
## ------------------------------------------------------------------------
library(vcfR)
library(tidyverse)

#' 
#' 
#' # A quick introduction
#' 
#' [vcfR tutorial: A quick introduction](https://knausb.github.io/vcfR_documentation/quick_intro.html)
#' 
#' ## Preliminaries
#' 
#' Since R reads all data into memory, sometimes it's best to split VCF data up into chromosomes.
#' 
#' ## Data input
#' 
#' vcfR works with VCF files and you can also add FASTA and GFF files for context, but these aren't required.
#' 
## ------------------------------------------------------------------------
library(pinfsc50)
pkg = "pinfsc50"
vcf_file = system.file("extdata", "pinf_sc50.vcf.gz", package = pkg)
dna_file = system.file("extdata", "pinf_sc50.fasta", package = pkg)
gff_file = system.file("extdata", "pinf_sc50.gff", package = pkg)

#' 
#' Read in the VCF file:
#' 
## ------------------------------------------------------------------------
vcf = read.vcfR(vcf_file, verbose=F)

#' 
#' The file is stored as a vcfR object (S4 class) with 3 slots, one each for metadata, fixed data, and genotype data. 
#' 
#' Read in FASTA files with the `ape` package:
#' 
## ------------------------------------------------------------------------
library("ape")
dna = read.dna(dna_file, format = "fasta")

#' 
#' Annotation files contain coordinates for genomic annotations. GFF is currently supported. Read in a GFF file with `read.table()`:
#' 
## ------------------------------------------------------------------------
gff = read.table(gff_file, sep = "\t", quote = "")

#' 
#' vcfR was designed to work with individual chromosomes as reading an entire genome into memory is a technical challenge.
#' 
#' ## Creating chromR objects
#' 
#' Once data is in memory, use `create.chromR()` to create a chromR object and populate it with VCF data.
#' 
## ------------------------------------------------------------------------
chrom = create.chromR(name="Supercontig", vcf = vcf, seq = dna, ann = gff)

#' 
#' Notice the warning that the contig names are not exactly the same bc of different sources. In this case the warning can be ignored because they refer to the same data.
#' 
#' The `name` parameter is the name of the chromR object and used when plotting it. 
#' 
#' ## Processing chromR objects
#' 
#' Get a quick look at the chromR object data by plotting.
#' 
## ------------------------------------------------------------------------
plot(chrom)

#' 
#' Use the `masker()` function to filter out low-confidence data. It uses quality, depth, and mapping quality to try and select high quality variants. Low quality variants are not deleted, but instead a logical vector is made to indicate which variants have been filtered.
#' 
## ------------------------------------------------------------------------
chrom = masker(chrom, min_QUAL = 1, min_DP = 300, max_DP = 700, min_MQ = 59.9, max_MQ = 60.1)
plot(chrom)

#' 
#' Once satisfied with filtering and the resulting set of high-quality variants, process the chromR object with `proc.chromR()`. This calls several helper functions to process the variant, sequence, and annotation data for viz.
#' 
## ------------------------------------------------------------------------
chrom = proc.chromR(chrom, verbose = T)
plot(chrom)

#' 
#' ## Visualizing the data
#' 
#' 3 types of data have been input: variant, sequence, and annotation. They've been inserted into a chromR object, and low-quality variants have been masked. High-quality variants were processed. Now we can visualize these data.
#' 
#' `chromoqc()` uses `layout()` to make composite plots.
#' 
## ------------------------------------------------------------------------
chromoqc(chrom, dp.alpha = 20)

#' 
#' Zoom in on a feature using `xlim()`.
#' 
## ------------------------------------------------------------------------
chromoqc(chrom, xlim=c(5e+05, 6e+05))

#' 
#' ## Output of data
#' 
#' ### Output to a VCF file
#' 
#' Variants determined to be high-quality by filtering with `masker()` can be output with `write.vcf()`. It takes a vcfR object and subsets it using the masked variants and output to a `*vcf.gz` file.
#' 
#' ### Conversion to other R objects
#' 
#' See other vignettes such as "Converting data".
#' 
#' # VCF data
#' 
#' Variant callers tend to aggressively call variants with the perspective that a downstream QC step will remove low quality variants.
#' 
#' ## Three sections
#' 
#' A VCF file can be thought of as having 3 sections:
#' 
#' 1. a metadata region (meta)
#' 1. a fixed region (fix)
#' 1. a genotype region (gt)
#' 
#' The ***meta region*** is at the top of the file and defines abbreviations used elsewhere in the file. It also documents software used in the creation of the VCF and maybe paramaters as well.
#' 
#' Below the meta region is the ***fixed data (fix) region***. These data are tabular and the first 8 columns contain info about the variants. These first 8 columns are required for a VCF. Other columns are common too. 
#' 
#' At column 10, there begins a column for each sample. These columns contain information about each sample for each variant. This is the ***genotype (gt) region***. The organization of each cell containing a genotype and associated info is specified in column 9.
#' 
#' VCFs are flexible - not all tools will use all types of VCF data, and non-standard data can be incorporated. This means that not all VCF files contain the same information.
#' 
#' For this example, use the data included with `vcfR`.
#' 
## ------------------------------------------------------------------------
data(vcfR_example)
vcf

#' 
#' ## The meta region
#' 
#' The meta region contains information about the file, its creation, as well as information to interpret abbreviations used elsewhere in the file. Each line begins with a double pound sign (##).
#' 
## ------------------------------------------------------------------------
# vcf@meta %>% head
vcf@meta[1:7]
# strwrap(vcf@meta[1:7])

#' 
#' 1st line: version of the VCF format. Required.
#' 
#' 2nd line: specifies software used to create the VCF. Not required. Entire pipeline does not get documented, e.g. which aligner was used upstream.
#' 
#' Lines 3+: Contain `INFO` or `FORMAT` specifications which define abbreviations used in the `fix` and `gt` regions.
#' 
#' The meta region may have long lines that are hard to view. To view them easily, use `queryMETA()`.
#' 
## ------------------------------------------------------------------------
queryMETA(vcf)

#' 
#' When an `element=` parameter is included, only info about that element is returned.
#' 
## ------------------------------------------------------------------------
queryMETA(vcf, element = "DP")

#' 
#' The element `DP` has both `INFO` and `FORMAT` definitions. Be more specific to only return one. The `<` is required to distinguish the `FORMAT` element from `INFO` element
#' 
## ------------------------------------------------------------------------
queryMETA(vcf, element = "FORMAT=<ID=DP", nice = F)

#' 
#' ## The fix region
#' 
#' This region contains info for each variant which is sometimes summarized over all samples. The first 8 columns are: `CHROM`, `POS`, `ID`, `REF`, `ALT`, `QUAL`, `FILTER`, and `INFO`. This is per-variant info and is fixed over all samples. Multiple alt alleles are delimited with commas.
#' 
#' Get the fixed region with `getFIX()`.
#' 
## ------------------------------------------------------------------------
getFIX(vcf) %>% head

#' 
#' The 8th column, `INFO`, is a `;`-delimited list of info which can be very long. `gewtFIX()` will suppress this column by default. Each abbreviation in the `INFO` column should be defined in the meta region.
#' 
#' ## The gt region
#' 
#' The `gt` (genotype) region contains info about each variant ***for each sample***. They are `:`-delimited. 
