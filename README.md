# chrombpnet-documentation
## General workflow
1. [Preprocessing](#preprocessing)
2. [Train bias model and ChromBPNet model](#5-fold-cross-validation-48-hours-to-run-24-for-bias-model-24-for-chrombpnet-model)
3. [Get contribution scores and merge across folds](#get-contribution-scores-28-hours-to-run)
4. [TF-MoDISco](#run-tf-modisco-lite)
5. [Fi-NeMo](#run-fi-nemo)

* [Variants of interest can be scored at any point after step 2](#score-variants-of-interest-with-variant-scorer)

ChromBPNet installation, environment creation, and workflow done according to tutorial [here](https://github.com/kundajelab/chrombpnet/wiki/Installation)

## Preprocessing
Data used -- ATAC-seq from four gastrocnemius medialis tissue samples:
- [ENCSR823ZCR](https://www.encodeproject.org/experiments/ENCSR823ZCR/)
  - Filtered .bam alignments: [ENCFF125LEJ](https://www.encodeproject.org/files/ENCFF125LEJ/)
  - Overlap peaks: [ENCFF751EAY](https://www.encodeproject.org/files/ENCFF751EAY/)
- [ENCSR308HPZ](https://www.encodeproject.org/experiments/ENCSR308HPZ/)
  - Filtered .bam alignments: [ENCFF256JHE](https://www.encodeproject.org/files/ENCFF256JHE/)
  - Overlap peaks: [ENCFF849FQV](https://www.encodeproject.org/files/ENCFF849FQV/)
- [ENCSR258JCL](https://www.encodeproject.org/experiments/ENCSR258JCL/)
  - Filtered .bam alignments: [ENCFF532PQX](https://www.encodeproject.org/files/ENCFF532PQX/)
  - Overlap peaks: [ENCFF080IAR](https://www.encodeproject.org/files/ENCFF080IAR/)
- [ENCSR689SDA](https://www.encodeproject.org/experiments/ENCSR689SDA/)
  - Filtered .bam alignments: [ENCFF531UDJ](https://www.encodeproject.org/files/ENCFF531UDJ/)
  - Overlap peaks: [ENCFF052XAY](https://www.encodeproject.org/files/ENCFF052XAY/)

Used filtered .bam alignments to train model and pseudoreplicated peaks in bed narrowPeak format for overlap peaks  
- [`preprocessing.sh`](preprocessing.sh)

<h6> The working directory for the preprocessing script is different from the rest of the scripts (data from preprocessing was copied into new directory in /data)
<ul> <li> preprocessing working directory: /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm </li> 
<li> downstream working directory: /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm </li> </h6>

## 5-fold cross-validation (~48 hours to run; 24 for bias model, 24 for ChromBPNet model)
Includes training bias model and ChromBPNet model  

Note: make separate directories for each fold and include the associated .json file (folder with splits [here](splits/))

- [`fold_0.sh`](/folds/fold_0.sh)
- [`fold_1.sh`](/folds/fold_1.sh)
- [`fold_2.sh`](/folds/fold_2.sh)
- [`fold_3.sh`](/folds/fold_3.sh)
- [`fold_4.sh`](/folds/fold_4.sh)

## Score variants of interest with [variant scorer](https://github.com/kundajelab/variant-scorer/tree/main)

Run commands in this script after navigating into variant-scorer repository (ex. `cd /home/knishino/github/variant-scorer/src`)  
- [`variant_scoring_all_folds.sh`](variant_scoring_all_folds.sh)
- Using variants in this file in original format: [`active_rsid.bed`](active_rsid.bed)
- To run summary command in above script, put all variant .tsv files into one directory
  - (ex. `mkdir /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/all_variant_scores`)
 
Note: variant scores aren't necessary for running TF-MoDISco (i.e. this step is independent from the following scripts)

## Get contribution scores (~28 hours to run)
Turn bed file into NarrowPeak format (done according to [ChromBPNet FAQ](https://github.com/kundajelab/chrombpnet/wiki/FAQ))

```
bedtools makewindows -b /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_overlap.bed -w 1000 -s 750 > /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed
```

To get correct data type and NarrowPeak format, manipulate data in R:

```
merged_windows <- read.table("/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed")

merged_windows$V4 <- "."
merged_windows$V5 <- "."
merged_windows$V6 <- "."
merged_windows$V7 <- "."
merged_windows$V8 <- "."
merged_windows$V9 <- "."
merged_windows$V10 <- as.integer((merged_windows$V3 - merged_windows$V2)/2)

merged_windows$V2 <- as.integer(merged_windows$V2)
merged_windows$V3 <- as.integer(merged_windows$V3)

write.table(merged_windows, "/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed", quote = F, col.names = F, row.names = F, sep="\t")
```

- [`fold_0_contribs.sh`](/folds_contribs/fold_0_contribs.sh)
- [`fold_1_contribs.sh`](/folds_contribs/fold_1_contribs.sh)
- [`fold_2_contribs.sh`](/folds_contribs/fold_2_contribs.sh)
- [`fold_3_contribs.sh`](/folds_contribs/fold_3_contribs.sh)
- [`fold_4_contribs.sh`](/folds_contribs/fold_4_contribs.sh)

## Merge contribution scores across folds
Python code adapted from [Marderstein^, Kundu^, et al. Mapping the regulatory effects of common and rare non-coding variants across cellular and developmental contexts in the brain and heart.](https://pubmed.ncbi.nlm.nih.gov/40027628/)     

Create two directories for profile and counts scores:  
  - (ex. `mkdir /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/merged_profile_folds`)
  - (ex. `mkdir /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/merged_counts_folds`)

(Code is the same for both profile and counts scores except for paths to appropriate .h5 file)   

Profile: [`mean_profile_h5.py`](contribution_scores/mean_profile_h5.py)   
Counts: [`mean_counts_h5.py`](contribution_scores/mean_counts_h5.py)

## Run [TF-MoDISco-lite](https://github.com/jmschrei/tfmodisco-lite)
Running with 1,000,000 seqlets and 500 bp window

Before running report script, get motifs of interest. Example:
```
wget https://jaspar.genereg.net/download/data/2022/CORE/JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme.txt -O /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme.txt
```

Profile:
- To get .h5 file: [`modisco_profile.sh`](/modisco/modisco_profile.sh)
- Report: [`modisco_profile_report.sh`](/modisco/modisco_profile_report.sh)
 
Counts:
- To get .h5 file: [`modisco_counts.sh`](/modisco/modisco_counts.sh)
- Report: [`modisco_counts_report.sh`](/modisco/modisco_counts_report.sh)

## Run [Fi-NeMo](https://github.com/austintwang/finemo_gpu)
- Preprocessing (profile and counts in same file): [`finemo_preprocessing.sh`](/finemo/finemo_preprocessing.sh)
- Hit calling
  - Profile: [`finemo_profile.sh`](/finemo/finemo_profile.sh)
  - Counts: [`finemo_counts.sh`](/finemo/finemo_counts.sh)

