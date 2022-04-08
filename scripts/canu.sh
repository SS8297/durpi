#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 05:00:00
#SBATCH -J Canu
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL

module load bioinfo-tools canu
cd $SNIC_TMP
rm -r ./*
cp ~/genome_analysis/durpi/data/pacbio_data/SRR6037732_scaffold_11.fq.gz $SNIC_TMP/SRR6037732_scaffold_11.fq.gz
mkdir ./assembly
canu -p durian-pacbio -d assembly/ genomeSize=23m useGrid=False -pacbio-raw ./SRR6037732_scaffold_11.fq.gz && cp -r assembly/* ~/genome_analysis/durpi/results/assembly/canu
cd ~/genome_analysis/durpi/scripts


