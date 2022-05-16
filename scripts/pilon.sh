#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 20:00:00
#SBATCH -J Pilon
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL
module  load bioinfo-tools Pilon
cd $SNIC_TMP
cp ~/genome_analysis/durpi/results/assembly/canu/durian-pacbio.contigs.fasta $SNIC_TMP/
cp ~/genome_analysis/durpi/results/assembly/bwa/durs_mem.bam $SNIC_TMP/
cp ~/genome_analysis/durpi/results/assembly/bwa/durs_mem.bai $SNIC_TMP/
mkdir pilon
java -Xmx32G -jar $PILON_HOME/pilon.jar --genome durian-pacbio.contigs.fasta --bam durs_mem.bam --threads 4 --outdir pilon/
cp -r pilon/  ~/genome_analysis/durpi/results/assembly/pilon/
