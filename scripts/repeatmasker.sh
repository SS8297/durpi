#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J RepeatMasker
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL

module load bioinfo-tools RepeatMasker
rm -r ~/genome_analysis/durpi/results/assembly/repeatmasker
cd $SNIC_TMP
cp ~/genome_analysis/durpi/results/assembly/pilon/pilon.fasta $SNIC_TMP/
mkdir repeatmasker
RepeatMasker -species Malvaceae -dir repeatmasker pilon.fasta
cp -r repeatmasker/  ~/genome_analysis/durpi/results/assembly/repeatmasker/
cd ~/genome_analysis/durpi/scripts
