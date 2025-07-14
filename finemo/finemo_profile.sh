#!/bin/bash
#
#SBATCH --job-name=finemo_profile
#SBATCH --time 14-
#SBATCH --partition=gpu
#SBATCH --gpus=1
#SBATCH --mem=96g
#SBATCH --account=tovar0
#SBATCH --mail-type ALL
#SBATCH --mail-user knishino@umich.edu
#SBATCH --output log.out
#SBATCH --error log.err

conda activate finemo
module load cuda/11.8
module load cudnn/11.8-v8.7.0

# hit calling
finemo call-hits -r /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/finemo/profile.npz \
        -m /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/modisco-mt/modisco.h5 \
        -o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/finemo/profile \
        -p /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed \
        -J
