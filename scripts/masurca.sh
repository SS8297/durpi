#!/bin/bash -l

#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 03:00:00
#SBATCH -J MaSuRCA
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL
#SBATCH --mem 128GB


module load bioinfo-tools MaSuRCA

rm -r ~/genome_analysis/durpi/results/assembly/masurca/
cd $SNIC_TMP
rm -r ./*
cp /home/shuai/genome_analysis/durpi/data/illumina_data/*_11.* $SNIC_TMP/
cp ~/genome_analysis/durpi/data/pacbio_data/SRR6037732_scaffold_11.fq.gz $SNIC_TMP/

perl /sw/bioinfo/MaSuRCA/4.0.4/snowy/bin/masurca \
-i SRR6058604_scaffold_11.1P.fastq.gz,SRR6058604_scaffold_11.2P.fastq.gz \
-r SRR6037732_scaffold_11.fq.gz -t 16

cp -r $SNIC_TMP/  /proj/uppmax2022-2-5/nobackup/work/shuai/masurca/
cd ~/genome_analysis/durpi/scripts
