# preprocessing (doesn't require gpu)
conda activate finemo

finemo extract-regions-chrombpnet-h5 -c /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/fold_0/fold_0_contribs_bw.profile_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/fold_1/fold_1_contribs_bw.profile_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/fold_2/fold_2_contribs_bw.profile_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/fold_3/fold_3_contribs_bw.profile_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/fold_4/fold_4_contribs_bw.profile_scores.h5 \
	-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/updated_contribs/profile_only/finemo/profile \
	-p /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed \
	-w 500


