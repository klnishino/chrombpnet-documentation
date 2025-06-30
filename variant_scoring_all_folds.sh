# navigate to variant-scoring directory and run:

python variant_scoring.py \
-l /nfs/turbo/umms-tovar/knishino/active_rsid.bed \
-g /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.fa \
-m /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_0/chrombpnet_model/models/chrombpnet_nobias.h5 \
-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_0/snp_score_pred/fold_0_snp_score \
-s /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.chrom.sizes \
-sc original

python variant_scoring.py \
-l /nfs/turbo/umms-tovar/knishino/active_rsid.bed \
-g /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.fa \
-m /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/chrombpnet_model/models/chrombpnet_nobias.h5 \
-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/snp_score_pred/fold_1_snp_score \
-s /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.chrom.sizes \
-sc original

python variant_scoring.py \
-l /nfs/turbo/umms-tovar/knishino/active_rsid.bed \
-g /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.fa \
-m /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_2/chrombpnet_model/models/chrombpnet_nobias.h5 \
-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_2/snp_score_pred/fold_2_snp_score \
-s /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.chrom.sizes \
-sc original

python variant_scoring.py \
-l /nfs/turbo/umms-tovar/knishino/active_rsid.bed \
-g /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.fa \
-m /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_3/chrombpnet_model/models/chrombpnet_nobias.h5 \
-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_3/snp_score_pred/fold_3_snp_score \
-s /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.chrom.sizes \
-sc original

python variant_scoring.py \
-l /nfs/turbo/umms-tovar/knishino/active_rsid.bed \
-g /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.fa \
-m /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_4/chrombpnet_model/models/chrombpnet_nobias.h5 \
-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_4/snp_score_pred/fold_4_snp_score \
-s /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/hg38.chrom.sizes \
-sc original

# put all tsv scoring files into one folder (here: "all_variant_scores")
python variant_summary_across_folds.py \
-sd /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/all_variant_scores \
-sl /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/all_variant_scores/fold_0_snp_score.variant_scores.tsv /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/all_variant_scores/fold_1_snp_score.variant_scores.tsv /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/all_variant_scores/fold_2_snp_score.variant_scores.tsv /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/all_variant_scores/fold_3_snp_score.variant_scores.tsv /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/all_variant_scores/fold_4_snp_score.variant_scores.tsv \
-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/all_variant_scores/all_folds \
-sc chrombpnet
