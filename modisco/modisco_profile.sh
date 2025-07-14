#!/bin/bash
#
#SBATCH --job-name=modisco
#SBATCH --time 14-
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --mem 32g
#SBATCH --account=tovar0
#SBATCH --mail-type ALL
#SBATCH --mail-user knishino@umich.edu
#SBATCH --output log.out
#SBATCH --error log.err

conda activate chrombpnet

export NUMBA_NUM_THREADS=24

modisco motifs -i /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/mean_contribs_bw.profile_scores.h5 \
-n 1000000 \
-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/modisco-mt/modisco_results.h5  \
-w 500 \
-v

