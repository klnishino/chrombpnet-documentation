# following tutorial here: https://github.com/kundajelab/chrombpnet/wiki/Tutorial
# main working directory: /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/
conda activate chrombpnet
module load cuda/11.8
module load cudnn/11.8-v8.7.0

mkdir -p /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads

# download reference data
wget https://www.encodeproject.org/files/GRCh38_no_alt_analysis_set_GCA_000001405.15/@@download/GRCh38_no_alt_analysis_set_GCA_000001405.15.fasta.gz -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/hg38.fa.gz
yes n | gunzip /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/hg38.fa.gz

# download reference chromosome sizes 
wget https://www.encodeproject.org/files/GRCh38_EBV.chrom.sizes/@@download/GRCh38_EBV.chrom.sizes.tsv -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/hg38.chrom.sizes

# download reference blacklist regions 
wget https://www.encodeproject.org/files/ENCFF356LFX/@@download/ENCFF356LFX.bed.gz -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/blacklist.bed.gz

# download bam files
wget https://www.encodeproject.org/files/ENCFF125LEJ/@@download/ENCFF125LEJ.bam -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/rep1.bam
wget https://www.encodeproject.org/files/ENCFF256JHE/@@download/ENCFF256JHE.bam -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/rep2.bam
wget https://www.encodeproject.org/files/ENCFF532PQX/@@download/ENCFF532PQX.bam -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/rep3.bam
wget https://www.encodeproject.org/files/ENCFF531UDJ/@@download/ENCFF531UDJ.bam -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/rep4.bam

# merge and index bam files
samtools merge -f /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/merged_unsorted.bam /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/rep1.bam  /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/rep2.bam  /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/rep3.bam /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/rep4.bam
samtools sort -@4 /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/merged_unsorted.bam -o /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/merged.bam
samtools index /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/merged.bam

# download overlap peaks (default peaks on ENCODE)
wget https://www.encodeproject.org/files/ENCFF751EAY/@@download/ENCFF751EAY.bed.gz -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/overlap1.bed.gz
wget https://www.encodeproject.org/files/ENCFF849FQV/@@download/ENCFF849FQV.bed.gz -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/overlap2.bed.gz
wget https://www.encodeproject.org/files/ENCFF080IAR/@@download/ENCFF080IAR.bed.gz -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/overlap3.bed.gz
wget https://www.encodeproject.org/files/ENCFF052XAY/@@download/ENCFF052XAY.bed.gz -O /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/overlap4.bed.gz

# merge overlap peaks
zcat /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/overlap1.bed.gz /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/overlap2.bed.gz /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/overlap3.bed.gz /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/overlap4.bed.gz > /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/cat_overlap.bed
sort -k1,1 -k2,2n /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/cat_overlap.bed > /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/sort_overlap.bed
bedtools merge -i /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/sort_overlap.bed \
        -c 4,5,6,7,8,9,10 -o collapse,mean,distinct,mean,mean,mean,mean \
        > /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/merged_overlap.bed

bedtools slop -i /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/blacklist.bed.gz -g /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/hg38.chrom.sizes -b 1057 > /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/temp.bed
bedtools intersect -v -a /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/merged_overlap.bed -b /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/temp.bed  > /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/peaks_no_blacklist.bed

head -n 24  /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/hg38.chrom.sizes >  /scratch/tovar_root/tovar0/knishino/20250616_chrombpnet-sm/data/downloads/hg38.chrom.subset.sizes

# may need to change data types to integers instead of floats (done in R)
