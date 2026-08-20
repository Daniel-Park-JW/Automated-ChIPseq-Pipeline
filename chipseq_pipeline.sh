#!/bin/bash

# Exit immediately if any command fails
set -e

echo "=========================================================="
echo "  Automated ChIP-Seq Processing Pipeline                  "
echo "=========================================================="

# Define variables for easy modification
RAW_DATA="raw_data/SRR577680.fastq.gz"
REF_INDEX="reference/chr22_index"
RESULTS_DIR="results"
SAMPLE_NAME="MCF7_CTCF"

echo "[1/4] Running Quality Control with FastQC..."
fastqc $RAW_DATA -o $RESULTS_DIR/

echo "[2/4] Aligning reads to reference genome with Bowtie2..."
bowtie2 -x $REF_INDEX -U $RAW_DATA -S $RESULTS_DIR/${SAMPLE_NAME}.sam

echo "[3/4] Compressing, sorting, and indexing with Samtools..."
samtools view -bS $RESULTS_DIR/${SAMPLE_NAME}.sam > $RESULTS_DIR/${SAMPLE_NAME}.bam
samtools sort $RESULTS_DIR/${SAMPLE_NAME}.bam -o $RESULTS_DIR/${SAMPLE_NAME}_sorted.bam
samtools index $RESULTS_DIR/${SAMPLE_NAME}_sorted.bam

echo "[4/4] Calling peaks with MACS3..."
macs3 callpeak -t $RESULTS_DIR/${SAMPLE_NAME}_sorted.bam -n $SAMPLE_NAME --outdir $RESULTS_DIR/ -f BAM -g hs --nomodel --extsize 200

echo "=========================================================="
echo "  Pipeline Complete! Peak files generated in $RESULTS_DIR."
echo "=========================================================="
