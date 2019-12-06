---
title: 'Learn: Biostrings'
output:
  html_document:
    keep_md: true
  html_notebook:
    theme: "darkly"
    toc: true
    toc_float:
      collapsed: false
    number_sections: true
  pdf_document:
    toc: true
---
<!-- params: -->

# Introduction

Biostrings reference site: [link](http://bioconductor.org/packages/release/bioc/html/Biostrings.html)

Workflow adapted from:

- ["R programming II: Sequence analysis with Biostrings"](http://www.bioinformatics-sannio.org/wordpress/wp-content/uploads/2015/06/R-programming-3.1-sequence-analysis-with-Biostrings.pdf), Luigi Cerulo, University of Sannio


```r
# Load packages
library(tidyverse)
```

```
## ── Attaching packages ──────── tidyverse 1.2.1 ──
```

```
## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
## ✔ tidyr   1.0.0     ✔ stringr 1.4.0
## ✔ readr   1.3.1     ✔ forcats 0.4.0
```

```
## ── Conflicts ─────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

```r
library(knitr)
library(Biostrings)
```

```
## Loading required package: BiocGenerics
```

```
## Loading required package: parallel
```

```
## 
## Attaching package: 'BiocGenerics'
```

```
## The following objects are masked from 'package:parallel':
## 
##     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
##     clusterExport, clusterMap, parApply, parCapply, parLapply,
##     parLapplyLB, parRapply, parSapply, parSapplyLB
```

```
## The following objects are masked from 'package:dplyr':
## 
##     combine, intersect, setdiff, union
```

```
## The following objects are masked from 'package:stats':
## 
##     IQR, mad, sd, var, xtabs
```

```
## The following objects are masked from 'package:base':
## 
##     anyDuplicated, append, as.data.frame, basename, cbind,
##     colnames, dirname, do.call, duplicated, eval, evalq, Filter,
##     Find, get, grep, grepl, intersect, is.unsorted, lapply, Map,
##     mapply, match, mget, order, paste, pmax, pmax.int, pmin,
##     pmin.int, Position, rank, rbind, Reduce, rownames, sapply,
##     setdiff, sort, table, tapply, union, unique, unsplit, which,
##     which.max, which.min
```

```
## Loading required package: S4Vectors
```

```
## Warning: package 'S4Vectors' was built under R version 3.6.1
```

```
## Loading required package: stats4
```

```
## 
## Attaching package: 'S4Vectors'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     first, rename
```

```
## The following object is masked from 'package:tidyr':
## 
##     expand
```

```
## The following object is masked from 'package:base':
## 
##     expand.grid
```

```
## Loading required package: IRanges
```

```
## Warning: package 'IRanges' was built under R version 3.6.1
```

```
## 
## Attaching package: 'IRanges'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     collapse, desc, slice
```

```
## The following object is masked from 'package:purrr':
## 
##     reduce
```

```
## Loading required package: XVector
```

```
## 
## Attaching package: 'XVector'
```

```
## The following object is masked from 'package:purrr':
## 
##     compact
```

```
## 
## Attaching package: 'Biostrings'
```

```
## The following object is masked from 'package:base':
## 
##     strsplit
```

```r
# Set working directory
opts_knit$set(root.dir = rprojroot::find_rstudio_root_file())
```

# Biostrings: basic functions

Define an example DNA sequence as a `DNAstring` object


```r
dna1 = DNAString("ATCGGTGCTAGATCGTATGCTAGC")
dna1
```

```
##   24-letter "DNAString" instance
## seq: ATCGGTGCTAGATCGTATGCTAGC
```

Look at the structure


```r
str(dna1)
```

```
## Formal class 'DNAString' [package "Biostrings"] with 5 slots
##   ..@ shared         :Formal class 'SharedRaw' [package "XVector"] with 2 slots
##   .. .. ..@ xp                    :<externalptr> 
##   .. .. ..@ .link_to_cached_object:<environment: 0x7ff161e58840> 
##   ..@ offset         : int 0
##   ..@ length         : int 24
##   ..@ elementMetadata: NULL
##   ..@ metadata       : list()
```

Look at the class


```r
class(dna1)
```

```
## [1] "DNAString"
## attr(,"package")
## [1] "Biostrings"
```

Get the reverse complement


```r
reverseComplement(dna1)
```

```
##   24-letter "DNAString" instance
## seq: GCTAGCATACGATCTAGCACCGAT
```

Translate to amino acid sequence


```r
translate(dna1)
```

```
##   8-letter "AAString" instance
## seq: IGARSYAS
```

Subset a sequence


```r
subseq(dna1, 3, 5)
```

```
##   3-letter "DNAString" instance
## seq: CGG
```

```r
dna1[3:5]
```

```
##   3-letter "DNAString" instance
## seq: CGG
```

Convert from `DNAString` object to a character vector


```r
as.character(dna1)
```

```
## [1] "ATCGGTGCTAGATCGTATGCTAGC"
```

List all available methods for the `DNAString` class


```r
methods(class="DNAString")
```

```
##   [1] !=                                         
##   [2] [                                          
##   [3] [<-                                        
##   [4] %in%                                       
##   [5] <                                          
##   [6] <=                                         
##   [7] ==                                         
##   [8] >                                          
##   [9] >=                                         
##  [10] aggregate                                  
##  [11] alphabetFrequency                          
##  [12] anyNA                                      
##  [13] append                                     
##  [14] as.character                               
##  [15] as.complex                                 
##  [16] as.data.frame                              
##  [17] as.env                                     
##  [18] as.integer                                 
##  [19] as.list                                    
##  [20] as.logical                                 
##  [21] as.matrix                                  
##  [22] as.numeric                                 
##  [23] as.raw                                     
##  [24] as.vector                                  
##  [25] bindROWS                                   
##  [26] by                                         
##  [27] c                                          
##  [28] chartr                                     
##  [29] codons                                     
##  [30] coerce                                     
##  [31] compact                                    
##  [32] compareStrings                             
##  [33] complement                                 
##  [34] countOverlaps                              
##  [35] countPattern                               
##  [36] countPDict                                 
##  [37] countPWM                                   
##  [38] duplicated                                 
##  [39] elementMetadata                            
##  [40] elementMetadata<-                          
##  [41] eval                                       
##  [42] expand                                     
##  [43] expand.grid                                
##  [44] extract_character_from_XString_by_positions
##  [45] extract_character_from_XString_by_ranges   
##  [46] extractAt                                  
##  [47] extractList                                
##  [48] extractROWS                                
##  [49] findOverlaps                               
##  [50] findPalindromes                            
##  [51] hasOnlyBaseLetters                         
##  [52] head                                       
##  [53] is.na                                      
##  [54] isMatchingEndingAt                         
##  [55] isMatchingStartingAt                       
##  [56] lcprefix                                   
##  [57] lcsubstr                                   
##  [58] lcsuffix                                   
##  [59] length                                     
##  [60] lengths                                    
##  [61] letter                                     
##  [62] letterFrequency                            
##  [63] letterFrequencyInSlidingView               
##  [64] make_XString_from_string                   
##  [65] maskMotif                                  
##  [66] masks                                      
##  [67] masks<-                                    
##  [68] match                                      
##  [69] matchLRPatterns                            
##  [70] matchPattern                               
##  [71] matchPDict                                 
##  [72] matchProbePair                             
##  [73] matchPWM                                   
##  [74] mcols                                      
##  [75] mcols<-                                    
##  [76] merge                                      
##  [77] mergeROWS                                  
##  [78] metadata                                   
##  [79] metadata<-                                 
##  [80] mstack                                     
##  [81] nchar                                      
##  [82] neditEndingAt                              
##  [83] neditStartingAt                            
##  [84] needwunsQS                                 
##  [85] NROW                                       
##  [86] oligonucleotideFrequency                   
##  [87] overlapsAny                                
##  [88] PairwiseAlignments                         
##  [89] PairwiseAlignmentsSingleSubject            
##  [90] palindromeArmLength                        
##  [91] palindromeLeftArm                          
##  [92] palindromeRightArm                         
##  [93] parallelSlotNames                          
##  [94] pcompare                                   
##  [95] pmatchPattern                              
##  [96] rank                                       
##  [97] relist                                     
##  [98] relistToClass                              
##  [99] rename                                     
## [100] rep                                        
## [101] rep.int                                    
## [102] replaceAt                                  
## [103] replaceLetterAt                            
## [104] replaceROWS                                
## [105] rev                                        
## [106] reverse                                    
## [107] reverseComplement                          
## [108] ROWNAMES                                   
## [109] seqtype                                    
## [110] seqtype<-                                  
## [111] setequal                                   
## [112] shiftApply                                 
## [113] show                                       
## [114] showAsCell                                 
## [115] sort                                       
## [116] split                                      
## [117] split<-                                    
## [118] subseq                                     
## [119] subseq<-                                   
## [120] subset                                     
## [121] subsetByOverlaps                           
## [122] substr                                     
## [123] substring                                  
## [124] table                                      
## [125] tail                                       
## [126] tapply                                     
## [127] toComplex                                  
## [128] toString                                   
## [129] transform                                  
## [130] translate                                  
## [131] trimLRPatterns                             
## [132] twoWayAlphabetFrequency                    
## [133] unique                                     
## [134] uniqueLetters                              
## [135] unmasked                                   
## [136] updateObject                               
## [137] values                                     
## [138] values<-                                   
## [139] vcountPattern                              
## [140] vcountPDict                                
## [141] Views                                      
## [142] vmatchPattern                              
## [143] vmatchPDict                                
## [144] vwhichPDict                                
## [145] which.isMatchingEndingAt                   
## [146] which.isMatchingStartingAt                 
## [147] whichPDict                                 
## [148] window                                     
## [149] window<-                                   
## [150] with                                       
## [151] xtabs                                      
## [152] xvcopy                                     
## see '?methods' for accessing help and source code
```


```r
dna1
```

```
##   24-letter "DNAString" instance
## seq: ATCGGTGCTAGATCGTATGCTAGC
```

```r
complement(dna1)
```

```
##   24-letter "DNAString" instance
## seq: TAGCCACGATCTAGCATACGATCG
```


```r
# genome_mm10 = readDNAStringSet(filepath = "")
```

