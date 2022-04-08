#!/bin/bash -l
#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 05:00:00
#SBATCH -J Canu
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL

module load bioinfo-tools trimmomatic
