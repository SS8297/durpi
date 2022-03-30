#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:01:00
#SBATCH -J FastQC
#SBATCH -o logs/Result_FastQC.output
#SBATCH -e logs/Error_FastQC.output
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL

fastqc -t 4 -o ~/genome_analysis/durpi/int_res/  ~/genome_analysis/durpi/data/pacbio_data/*
fastqc -t 4 -o ~/genome_analysis/durpi/int_res/fastqc/ill_pre/ ~/genome_analysis/durpi/data/illumina_data/*
