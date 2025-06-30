# neuro variants github adapted code

import h5py
import numpy as np
import os
import deepdish
import shutil

fold_0_file_path = "/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_0/contribs_bw/fold_0_contribs_bw.counts_scores.h5"
fold_1_file_path = "/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_1/contribs_bw/fold_1_contribs_bw.counts_scores.h5"
fold_2_file_path = "/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_2/contribs_bw/fold_2_contribs_bw.counts_scores.h5"
fold_3_file_path = "/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_3/contribs_bw/fold_3_contribs_bw.counts_scores.h5"
fold_4_file_path = "/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/fold_4/contribs_bw/fold_4_contribs_bw.counts_scores.h5"

outfile_h5 = "/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/merged_counts_folds/mean_contribs_bw.counts_scores.h5"
outfile_npz_ohe = "/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/counts_ohe.npz"
outfile_npz_shap = "/scratch/tovar_root/tovar0/knishino/chrombpnet-encode-sm/counts_shap.npz"

shap_dict = {}
projected_shap_dict = {}
onehot = []

infile0 = fold_0_file_path
infile1 = fold_1_file_path
infile2 = fold_2_file_path
infile3 = fold_3_file_path
infile4 = fold_4_file_path

fold0 = "fold_0"
fold1 = "fold_1"
fold2 = "fold_2"
fold3 = "fold_3"
fold4 = "fold_4"

shap_dict[fold0] = deepdish.io.load(infile0, '/shap/seq')
projected_shap_dict[fold0] = deepdish.io.load(infile0, '/projected_shap/seq')
onehot = deepdish.io.load(infile0, '/raw/seq')

shap_dict[fold1] = deepdish.io.load(infile1, '/shap/seq')
projected_shap_dict[fold1] = deepdish.io.load(infile1, '/projected_shap/seq')

shap_dict[fold2] = deepdish.io.load(infile2, '/shap/seq')
projected_shap_dict[fold2] = deepdish.io.load(infile2, '/projected_shap/seq')

shap_dict[fold3] = deepdish.io.load(infile3, '/shap/seq')
projected_shap_dict[fold3] = deepdish.io.load(infile3, '/projected_shap/seq')

shap_dict[fold4] = deepdish.io.load(infile4, '/shap/seq')
projected_shap_dict[fold4] = deepdish.io.load(infile4, '/projected_shap/seq')

mean_shap = np.mean(np.array([shap_dict[fold] for fold in shap_dict]), axis=0)
mean_projected_shap = np.mean(np.array([projected_shap_dict[fold] for fold in projected_shap_dict]), axis=0)
d = {
    'raw': {'seq': onehot},
    'shap': {'seq': mean_shap},
    'projected_shap': {'seq': mean_projected_shap}
}

deepdish.io.save(outfile_h5, d, compression='blosc')
np.savez(outfile_npz_ohe, mean_shap)
np.savez(outfile_npz_shap, onehot)
