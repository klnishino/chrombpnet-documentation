#!/bin/bash
#
#SBATCH --job-name=finemo_counts
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

# hit calling
finemo call-hits -r /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/finemo/counts.npz \
	-m  /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/merged_counts_folds/modisco_w_500/modisco.h5 \
	-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/finemo/counts \
	-p /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed \
	-J

	

