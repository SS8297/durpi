#!/bin/bash -l

#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 06:00:00
#SBATCH -J Pilon
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL

module load bioinfo-tools eggNOG-mapper
rm -r ~/genome_analysis/durpi/results/assembly/eggnog/
cd $SNIC_TMP
cp ~/genome_analysis/durpi/results/assembly/repeatmasker/pilon.fasta.masked $SNIC_TMP/
mkdir eggnog/
python /sw/bioinfo/eggNOG-mapper/2.1.5/snowy/bin/emapper.py --cpu 16 -i pilon.fasta.masked --itype genome --output_dir eggnog/ -o durpi
cp -r eggnog/  ~/genome_analysis/durpi/results/assembly/eggnog/
cd ~/genome_analysis/durpi/scripts
