#!/bin/sh
#PBS -l walltime=04:00:00,nodes=1:ppn=16:gpus=3
#PBS -j oe

source ~/init.sh
cd $PBS_O_WORKDIR

./time.sh
