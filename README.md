# chrombpnet-documentation
ChromBPNet installation and environment creation done according to tutorial [here](https://github.com/kundajelab/chrombpnet/wiki/Installation)

Data used -- ATAC-seq from four gastrocnemius medialis tissue samples:
- [ENCSR823ZCR](https://www.encodeproject.org/experiments/ENCSR823ZCR/)
- [ENCSR308HPZ](https://www.encodeproject.org/experiments/ENCSR308HPZ/)
- [ENCSR258JCL](https://www.encodeproject.org/experiments/ENCSR258JCL/)
- [ENCSR689SDA](https://www.encodeproject.org/experiments/ENCSR689SDA/)

## Preprocessing

**`preprocessing.sh`**

## 5-fold cross-validation (~48 hours to run)
Includes training bias model and ChromBPNet model

[**`fold_0.sh`**](/folds/fold_0.sh)
[**`fold_1.sh`**](/folds/fold_1.sh)
[**`fold_2.sh`**](/folds/fold_2.sh)
[**`fold_3.sh`**](/folds/fold_3.sh)
[**`fold_4.sh`**](/folds/fold_4.sh)

## Score variants of interest
According to [variant scorer](https://github.com/kundajelab/variant-scorer/tree/main)
Run commands in this script after navigating into copied github repository with python scripts:
[**`variant_scoring_all_folds.sh`**](variant_scoring_all_folds.sh)
Using variants in this file in original format: [**`active_rsid.bed`**](active_rsid.bed)

## Get contribution scores (~28 hours to run)
Turn bed file into NarrowPeak format (done according to [ChromBPNet FAQ](https://github.com/kundajelab/chrombpnet/wiki/FAQ)

`bedtools makewindows -b /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_overlap.bed -w 1000 -s 750 > /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed`

[**`fold_0_contribs.sh`**](/folds/fold_0_contribs.sh)
[**`fold_1_contribs.sh`**](/folds/fold_1_contribs.sh)
[**`fold_2_contribs.sh`**](/folds/fold_2_contribs.sh)
[**`fold_3_contribs.sh`**](/folds/fold_3_contribs.sh)
[**`fold_4_contribs.sh`**](/folds/fold_4_contribs.sh)

## Merge contribution scores across folds (for both profile and counts scores)
Profile: [**`mean_profile_h5.py`**](contribution_scores/mean_profile_h5.py)
Counts: [**`mean_counts_h5.py`**](contribution_scores/mean_counts_h5.py)


