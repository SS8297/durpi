#!/bin/bash -l

#SBATCH -A uppmax2022-2-5
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 16
#SBATCH -t 00:30:00
#SBATCH -J Star
#SBATCH --mail-user shuai.shao.5274@student.uu.se
#SBATCH --mail-type=END,FAIL

module load bioinfo-tools star
rm -r ~/genome_analysis/durpi/results/assembly/star/
cd $SNIC_TMP
rm -r ./*
cp ~/genome_analysis/durpi/results/assembly/trimmomatic/*P.fastq.gz $SNIC_TMP/
cp ~/genome_analysis/durpi/data/transcriptome/trimmed/*_11.* $SNIC_TMP/
cp ~/genome_analysis/durpi/results/assembly/repeatmasker/pilon.fasta.masked $SNIC_TMP/

mkdir star/
star --runThreadN 16 \
--runMode genomeGenerate \
--genomeDir star/ \
--genomeFastaFiles pilon.fasta.masked \
--genomeSAindexNbases 11

declare n=0
declare pairedReads=""
for file in *.fastq.gz;
do
	declare pairedReads="$pairedReads $file"
        if [ $n -eq 1 ];
        then
	declare bName=$(basename ${file%%.*})
        echo "$pairedReads"
        declare n=0
        star --runThreadN 16 \
	--runMode alignReads \
        --genomeDir star/ \
        --genomeFastaFiles pilon.fasta.masked \
        --outSAMtype SAM \
	--outFileNamePrefix star/$bName \
	--readFilesCommand zcat \
        --readFilesIn $pairedReads &
        declare pairedReads=""
        else
        declare n=1
	fi
done

wait

# cp -r star/  ~/genome_analysis/durpi/results/assembly/star/
cp -r star/ /proj/uppmax2022-2-5/nobackup/work/shuai/star/
cd ~/genome_analysis/durpi/scripts
