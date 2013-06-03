#!/bin/sh
#PBS -l walltime=12:00:00,nodes=1:ppn=4:gpus=1
#PBS -j oe

source ~/init.sh
cd $PBS_O_WORKDIR

./run.sh
