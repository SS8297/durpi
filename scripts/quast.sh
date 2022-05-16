#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 00:15:00
#SBATCH -J Quast
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL
#SBATCH --qos=short

module  load bioinfo-tools quast
rm -r ~/genome_analysis/durpi/results/assembly/quast/
cd $SNIC_TMP
cp ~/genome_analysis/durpi/results/assembly/pilon/pilon.fasta $SNIC_TMP/
mkdir quast/
python /sw/bioinfo/quast/5.0.2/snowy/bin/quast.py -o quast/ -t 8 -e pilon.fasta
cp -r quast/  ~/genome_analysis/durpi/results/assembly/quast/
