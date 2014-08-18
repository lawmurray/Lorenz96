#!/bin/sh

libbi sample @config.conf @bifurc.conf --model-file Lorenz96Deterministic.bi --output-file results/bifurc_deterministic.nc
libbi sample @config.conf @bifurc.conf --model-file Lorenz96Stochastic.bi --output-file results/bifurc_stochastic.nc
