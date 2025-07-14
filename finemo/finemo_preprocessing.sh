# preprocessing (doesn't require gpu)
conda activate finemo

finemo extract-regions-chrombpnet-h5 -c /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_0/contribs_bw/fold_0_contribs_bw.profile_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/contribs_bw/fold_1_contribs_bw.profile_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_2/contribs_bw/fold_2_contribs_bw.profile_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_3/contribs_bw/fold_3_contribs_bw.profile_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_4/contribs_bw/fold_4_contribs_bw.profile_scores.h5 \
	-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/finemo/profile \
	-p /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed \
	-w 500

finemo extract-regions-chrombpnet-h5 -c /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_0/contribs_bw/fold_0_contribs_bw.counts_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/contribs_bw/fold_1_contribs_bw.counts_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_2/contribs_bw/fold_2_contribs_bw.counts_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_3/contribs_bw/fold_3_contribs_bw.counts_scores.h5 /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_4/contribs_bw/fold_4_contribs_bw.counts_scores.h5 \
	-o /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/finemo/counts \
	-p /scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/data/downloads/merged_windows.bed \
	-w 500
