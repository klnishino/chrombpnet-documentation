# chrombpnet-documentation
ChromBPNet installation and environment creation done according to tutorial [here](https://github.com/kundajelab/chrombpnet/wiki/Installation)

Data used -- ATAC-seq from four gastrocnemius medialis tissue samples:
- [ENCSR823ZCR](https://www.encodeproject.org/experiments/ENCSR823ZCR/)
- [ENCSR308HPZ](https://www.encodeproject.org/experiments/ENCSR308HPZ/)
- [ENCSR258JCL](https://www.encodeproject.org/experiments/ENCSR258JCL/)
- [ENCSR689SDA](https://www.encodeproject.org/experiments/ENCSR689SDA/)

## Preprocessing  
Used filtered .bam alignments and pseudoreplicated peaks in bed narrowPeak format for overlap peaks  
[**`preprocessing.sh`**](preprocessing.sh)

## 5-fold cross-validation (~48 hours to run)
Includes training bias model and ChromBPNet model  
- [**`fold_0.sh`**](/folds/fold_0.sh)
- [**`fold_1.sh`**](/folds/fold_1.sh)
- [**`fold_2.sh`**](/folds/fold_2.sh)
- [**`fold_3.sh`**](/folds/fold_3.sh)
- [**`fold_4.sh`**](/folds/fold_4.sh)

## Score variants of interest with [variant scorer](https://github.com/kundajelab/variant-scorer/tree/main)

Run commands in this script after navigating into variant-scorer repository (ex. `cd /home/knishino/github/variant-scorer/src`)  
- [**`variant_scoring_all_folds.sh`**](variant_scoring_all_folds.sh)
- Using variants in this file in original format: [**`active_rsid.bed`**](active_rsid.bed)

## Get contribution scores (~28 hours to run)
Turn bed file into NarrowPeak format (done according to [ChromBPNet FAQ](https://github.com/kundajelab/chrombpnet/wiki/FAQ))

`bedtools makewindows -b /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_overlap.bed -w 1000 -s 750 > /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed`

- [**`fold_0_contribs.sh`**](/folds/fold_0_contribs.sh)
- [**`fold_1_contribs.sh`**](/folds/fold_1_contribs.sh)
- [**`fold_2_contribs.sh`**](/folds/fold_2_contribs.sh)
- [**`fold_3_contribs.sh`**](/folds/fold_3_contribs.sh)
- [**`fold_4_contribs.sh`**](/folds/fold_4_contribs.sh)

## Merge contribution scores across folds
(Code is the same for both profile and counts scores except for paths to appropriate .h5 file)   
Profile: [**`mean_profile_h5.py`**](contribution_scores/mean_profile_h5.py)   
Counts: [**`mean_counts_h5.py`**](contribution_scores/mean_counts_h5.py)

## Run [TF-MoDISco-lite](https://github.com/jmschrei/tfmodisco-lite) (~probably forever)  
Running with 1,000,000 seqlets and 500bp window   
Profile:
- To get .h5 file: [**`modisco_profile.sh`**](/modisco/modisco_profile.sh)
- Report: [**`modisco_profile_report.sh`**](/modisco/modisco_profile_report.sh)
Counts:
- To get .h5 file: [**`modisco_counts.sh`**](/modisco/modisco_counts.sh)
- Report: [**`modisco_counts_report.sh`**](/modisco/modisco_counts_report.sh)


