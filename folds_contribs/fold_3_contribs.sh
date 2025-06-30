#!/bin/bash
#
#SBATCH --job-name=f3_contribs_bw
#SBATCH --time 14-
#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --mem=96g
#SBATCH --account=tovar0
#SBATCH --mail-type ALL
#SBATCH --mail-user knishino@umich.edu
#SBATCH --output log.out
#SBATCH --error log.err

conda activate chrombpnet
module load cuda/11.8
module load cudnn/11.8-v8.7.0

# get merged regions according to FAQ
# bedtools makewindows -b /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_overlap.bed -w 1000 -s 750 > /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed


chrombpnet contribs_bw \
		-m /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_3/chrombpnet_model/models/chrombpnet_nobias.h5 \
		-r /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed \
		-g /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.fa \
		-c /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.chrom.sizes\
		-op /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_3/contribs_bw/fold_3_contribs_bw

