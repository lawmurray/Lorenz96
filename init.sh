#!/bin/sh

# simulate a dense data set
libbi sample @config.conf --target joint --model-file Lorenz96.bi --end-time 3 --noutputs 30 --nsamples 1 --init-file data/init.nc --output-file data/obs_dense.nc --seed -1

# extract a sparse data set using OctBi
rm -f data/obs_sparse.nc
octave --path oct -q --eval "bi_sparsify_var('data/obs_dense.nc', 'data/obs_sparse.nc', 'y', [1:4]')"
