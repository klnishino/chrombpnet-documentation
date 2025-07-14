#!/bin/bash
#
#SBATCH --job-name=modisco_profile_report
#SBATCH --time 14-
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem 32g
#SBATCH --account=tovar0
#SBATCH --mail-type ALL
#SBATCH --mail-user knishino@umich.edu
#SBATCH --output log.out
#SBATCH --error log.err

# do once for download motifs of choice
# wget \
#	https://jaspar.genereg.net/download/data/2022/CORE/JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme.txt \
#	-O /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme.txt

conda activate chrombpnet

modisco report -i /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/modisco-mt/modisco_results.h5 \
	-o report/ \
	-s /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/modisco-mt/report/ \
	-m /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/merged_profile_folds/modisco_test/data/JASPAR2022_CORE_vertebrates_non-redundant_pfms_meme.txt
