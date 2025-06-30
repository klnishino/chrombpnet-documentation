#!/bin/bash
#
#SBATCH --job-name=modisco_counts
#SBATCH --time 14-
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem 180g
#SBATCH --account=tovar0
#SBATCH --mail-type ALL
#SBATCH --mail-user knishino@umich.edu
#SBATCH --output log.out
#SBATCH --error log.err

conda activate chrombpnet

modisco motifs -i /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/merged_counts_folds/mean_contribs_bw.counts_scores.h5 \
-n 1000000 \
-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/merged_counts_folds/modisco/modisco_results.h5 \
-w 500 \
-v

