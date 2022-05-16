#!/bin/bash -l

#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 02:00:00
#SBATCH -J Braker
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL


module load bioinfo-tools samtools/1.8 braker/2.1.1_Perl5.24.1 augustus/3.2.3_Perl5.24.1 \
bamtools/2.5.1 blast/2.9.0+ GenomeThreader/1.7.0 GeneMark/4.33-es_Perl5.24.1

source $AUGUSTUS_CONFIG_COPY
chmod a+w -R $PWD/augustus_config/species/
chmod a+w -R $HOME/genome_analysis/durpi/scripts/augustus_config/species/
cp -vf /sw/bioinfo/GeneMark/4.33-es/snowy/gm_key $HOME/.gm_key


rm -r ~/genome_analysis/durpi/results/assembly/braker/
cd $SNIC_TMP
rm -r ./*
cp ~/genome_analysis/durpi/results/assembly/star/*Aligned.sortedByCoord.out.bam $SNIC_TMP/
cp ~/genome_analysis/durpi/results/assembly/repeatmasker/pilon.fasta.masked $SNIC_TMP/

mkdir braker/

declare bams=""
for bam in *Aligned.sortedByCoord.out.bam;
do
if [ -z "${bams}" ];
then	
declare bams=$bam
else
declare bams=$bams,$bam
fi
done

/sw/bioinfo/braker/2.1.1/snowy/braker.pl \
--genome=pilon.fasta.masked \
--bam=$bams  \
--species=durio_zibethinus \
--gff3 \
--cores=8 \
--workingdir=braker/ \
--AUGUSTUS_CONFIG_PATH=/home/shuai/genome_analysis/durpi/scripts/augustus_config \
--AUGUSTUS_BIN_PATH=/sw/bioinfo/augustus/3.4.0/snowy/bin \
--AUGUSTUS_SCRIPTS_PATH=/sw/bioinfo/augustus/3.4.0/snowy/scripts \
--GENEMARK_PATH=/sw/bioinfo/GeneMark/4.33-es/snowy \
--useexisting

cp -r braker/  ~/genome_analysis/durpi/results/assembly/braker/
cd ~/genome_analysis/durpi/scripts
