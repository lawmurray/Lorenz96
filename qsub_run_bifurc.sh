#!/bin/sh
#PBS -l walltime=01:00:00,nodes=1:ppn=4:gpus=1,vmem=16gb
#PBS -j oe

source ~/init.sh
#module load libbi
cd $PBS_O_WORKDIR

./run_bifurc.sh
