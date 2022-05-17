#!/bin/bash -l

#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 06:00:00
#SBATCH -J Trinity
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL
#SBATCH --mem 128GB

module load bioinfo-tools trinity

rm -r ~/genome_analysis/durpi/results/assembly/trinity/
cd $SNIC_TMP
rm -r ./*
cp ~/genome_analysis/durpi/results/assembly/trimmomatic/*P.fastq.gz $SNIC_TMP/
cp ~/genome_analysis/durpi/data/transcriptome/trimmed/*_11.* $SNIC_TMP/
cp /home/shuai/genome_analysis/durpi/scripts/samples.tsv $SNIC_TMP/
mkdir trinity/

for bam in *Aligned.sortedByCoord.out.bam;
do
Trinity --seqType fq --samples_file samples.tsv --max_memory 128G --CPU 16 --output trinity/ &
done
wait

cp -r trinity/  ~/genome_analysis/durpi/results/assembly/trinity/
cd ~/genome_analysis/durpi/scripts
