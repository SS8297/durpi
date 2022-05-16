#!/bin/bash -l

#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 03:00:00
#SBATCH -J Htseq
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL

module load bioinfo-tools htseq samtools

rm -r ~/genome_analysis/durpi/results/assembly/htseq/
cd $SNIC_TMP
rm -r ./*
cp ~/genome_analysis/durpi/results/assembly/star/*Aligned.sortedByCoord.out.bam $SNIC_TMP/
cp ~/genome_analysis/durpi/results/assembly/braker/augustus.hints.gff3  $SNIC_TMP/

mkdir htseq/

for bam in *.bam;
do
samtools index -@ 8 $bam &&
python3 /sw/bioinfo/htseq/0.12.4/snowy/bin/htseq-count -r pos -n 8 -i ID $bam augustus.hints.gff3 &
done
wait

rm *.bam
rm *.bai
cp -p ./*  ~/genome_analysis/durpi/results/assembly/htseq/
cd ~/genome_analysis/durpi/scripts
