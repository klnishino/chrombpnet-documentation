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

**`fold_0.sh`**
**`fold_1.sh`**
**`fold_2.sh`**
**`fold_3.sh`**
**`fold_4.sh`**

## Get contribution scores
Turn bed file into NarrowPeak format (done according to [ChromBPNet FAQ](https://github.com/kundajelab/chrombpnet/wiki/FAQ)
`bedtools makewindows -b /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_overlap.bed -w 1000 -s 750 > /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed`

**`fold_0_contribs.sh`**
**`fold_1_contribs.sh`**
**`fold_2_contribs.sh`**
**`fold_3_contribs.sh`**
**`fold_4_contribs.sh`**


