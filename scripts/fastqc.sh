#!/bin/bash -l
module load bioinfo-tools FastQC
for file in ~/genome_analysis/durpi/data/pacbio_data/*
do
echo "fastqc $file -t 4 -o ~/durpi/int_res/fastqc &"
done

