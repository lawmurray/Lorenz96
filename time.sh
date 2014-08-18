#!/bin/sh

# configurations
CONFIG_COMMON="--disable-assert --enable-single --enable-timing --nparticles 8192 --output-file \"\""
CONFIG1="--nthreads 1"
CONFIG2="--nthreads 4"
CONFIG3="--nthreads 1 --enable-avx"
CONFIG4="--nthreads 4 --enable-avx"
CONFIG5="--nthreads 1 --enable-cuda"
CONFIG6="--nthreads 4 --enable-cuda"
CONFIG7="--nthreads 4 --enable-avx --enable-mpi --mpi-npernode 3"
CONFIG8="--nthreads 4 --enable-cuda --enable-mpi --mpi-npernode 3"

echo "Particle filter"
echo "---------------"
echo -n "1: "; eval "libbi filter @filter.conf $CONFIG_COMMON $CONFIG1"
echo -n "2: "; eval "libbi filter @filter.conf $CONFIG_COMMON $CONFIG2"
echo -n "3: "; eval "libbi filter @filter.conf $CONFIG_COMMON $CONFIG3"
echo -n "4: "; eval "libbi filter @filter.conf $CONFIG_COMMON $CONFIG4"
echo -n "5: "; eval "libbi filter @filter.conf $CONFIG_COMMON $CONFIG5"
echo -n "6: "; eval "libbi filter @filter.conf $CONFIG_COMMON $CONFIG6"
echo

# PMCMC timing
echo "Particle marginal Metropolis-Hastings"
echo "-------------------------------------"
echo -n "1: "; eval "libbi sample @posterior.conf --nsamples 500 $CONFIG_COMMON $CONFIG1 2> /dev/null"
echo -n "2: "; eval "libbi sample @posterior.conf --nsamples 500 $CONFIG_COMMON $CONFIG2 2> /dev/null"
echo -n "3: "; eval "libbi sample @posterior.conf --nsamples 500 $CONFIG_COMMON $CONFIG3 2> /dev/null"
echo -n "4: "; eval "libbi sample @posterior.conf --nsamples 500 $CONFIG_COMMON $CONFIG4 2> /dev/null"
echo -n "5: "; eval "libbi sample @posterior.conf --nsamples 500 $CONFIG_COMMON $CONFIG5 2> /dev/null"
echo -n "6: "; eval "libbi sample @posterior.conf --nsamples 500 $CONFIG_COMMON $CONFIG6 2> /dev/null"
echo

# SMC2 timing
echo "SMC^2"
echo "-----"
echo -n "1: "; eval "libbi sample @posterior_sir.conf $CONFIG_COMMON $CONFIG1 --nsamples 192 2> /dev/null"
echo -n "2: "; eval "libbi sample @posterior_sir.conf $CONFIG_COMMON $CONFIG2 --nsamples 192 2> /dev/null"
echo -n "3: "; eval "libbi sample @posterior_sir.conf $CONFIG_COMMON $CONFIG3 --nsamples 192 2> /dev/null"
echo -n "4: "; eval "libbi sample @posterior_sir.conf $CONFIG_COMMON $CONFIG4 --nsamples 192 2> /dev/null"
echo -n "5: "; eval "libbi sample @posterior_sir.conf $CONFIG_COMMON $CONFIG5 --nsamples 192 2> /dev/null"
echo -n "6: "; eval "libbi sample @posterior_sir.conf $CONFIG_COMMON $CONFIG6 --nsamples 192 2> /dev/null"
echo -n "7: "; eval "libbi sample @posterior_sir.conf $CONFIG_COMMON $CONFIG7 --nsamples 192 2> /dev/null"
echo -n "8: "; eval "libbi sample @posterior_sir.conf $CONFIG_COMMON $CONFIG8 --nsamples 192 2> /dev/null"
echo
