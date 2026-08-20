# Automated ChIP-Seq Processing Pipeline

## Overview
An automated, end-to-end bash script for processing Next-Generation Sequencing (NGS) ChIP-seq data. This pipeline takes raw single-end sequence reads (`.fastq.gz`), aligns them to a reference genome, processes the alignments, and identifies statistically significant protein-DNA binding sites (peaks).

## Pipeline Architecture
1. **Quality Control:** `FastQC` generates HTML reports on read quality.
2. **Alignment:** `Bowtie2` maps raw reads against the reference genome index.
3. **Processing:** `Samtools` compresses, sorts, and indexes the alignment maps into binary format (`.bam`).
4. **Peak Calling:** `MACS3` identifies regions of enrichment (peaks) and outputs standard `.narrowPeak` and `.bed` files.

## Usage
The pipeline is designed for strict error handling (`set -e`) and requires a pre-built reference index and raw FASTQ files in the working directory.

```bash
chmod +x chipseq_pipeline.sh
./chipseq_pipeline.sh


