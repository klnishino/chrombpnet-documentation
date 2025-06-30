#!/bin/bash
#
#SBATCH --job-name=fold_1
#SBATCH --time 14-
#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --mem=32g
#SBATCH --account=tovar0
#SBATCH --mail-type ALL
#SBATCH --mail-user knishino@umich.edu
#SBATCH --output log.out
#SBATCH --error log.err

conda activate chrombpnet
module load cuda/11.8
module load cudnn/11.8-v8.7.0

# create output_negatives.bed
chrombpnet prep nonpeaks \
        -g /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.fa \
        -p /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/peaks_no_blacklist.bed \
        -c /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.chrom.sizes \
        -fl /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/splits/fold_1.json \
        -br /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/blacklist.bed.gz \
        -o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/data/output

# create bias model per fold
mkdir /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/bias_model
chrombpnet bias pipeline \
        -ibam /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged.bam \
        -d "ATAC" \
        -g /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.fa \
        -c /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.chrom.sizes \
        -p /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/peaks_no_blacklist.bed \
        -n /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/data/output_negatives.bed \
        -fl /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/splits/fold_1.json  \
        -b 0.5 \
        -o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/bias_model

# train model
chrombpnet pipeline \
        -ibam /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged.bam \
        -d "ATAC" \
        -g /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.fa \
        -c /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.chrom.sizes \
        -p /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/peaks_no_blacklist.bed \
        -n /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/data/output_negatives.bed \
        -fl /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/splits/fold_1.json \
        -b /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/bias_model/models/bias.h5 \
        -o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/chrombpnet_model/