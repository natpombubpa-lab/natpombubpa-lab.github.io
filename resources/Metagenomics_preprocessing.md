---
title: Metagenomics preprocessing (Data curation and analysis)
image: AMPtk.jpg
---

# Metagenomics preprocessing (Data curation and analysis)

Metagenomics preprocessing refers to the initial computational steps applied to raw sequencing data to ensure data quality, consistency, and analytical readiness before downstream analyses. This stage focuses on data curation and primary analysis, aiming to minimize technical noise while preserving biologically relevant signals.

## A: What is Pipeline ?
“A bioinformatics pipeline is a set of complex algorithms (tools), which is used to process sequence data”

This stage includes quality assessment, removal of low-quality reads and artifacts, adapter trimming, contaminant or host filtering, and metadata standardization, followed by basic normalization and preliminary taxonomic or functional profiling to validate data integrity and inform subsequent analyses.

## A: Pipeline overview

## B: HPCC and Shell script
HPCC (High-Performance Computing Cluster) is an open-source, data-intensive computing platform for processing and analyzing massive, complex datasets

The HPCC platform incorporates a software architecture implemented on commodity computing clusters to provide high-performance, data-parallel processing for applications utilizing big data.

What is Shell?
A shell is special user program which provide an interfae to user to use operating system services. Shell accept human readable commands from user and convert them into something which kernel can understand. The shell gets started when the user logs in or start the terminal.

## C: Details on Script
The script will be as .sh extension which is a shell script. It is a plain text file that contains a sequence of commands that are executed by a Unix shell, which is a command-line interpreter. 


Called as “shebang” or Run this script using the Bash shell

{:.left}
```bash
#!/bin/bash
#SBATCH --job-name=decontam_assembly_CO884
#SBATCH --output=decontam_assembly_CO884_%j.out
#SBATCH --error=decontam_assembly_CO884_%j.err
#SBATCH --time=48:00:00
#SBATCH --ntasks=16
#SBATCH --mem=256G
#SBATCH --array=1-3
```

Load module that is prepared in HPCC system
{:.left}
```bash
# Load required modules
module load bowtie2
module load megahit
```

Configure where are the directory for the analysis located
{:.left}
```bash
# Configuration
INPUT_DIR="/bigdata/pombubpalab/shared/FAILSAFE/training_feb2026/sequence"
WORK_DIR="/bigdata/pombubpalab/shared/FAILSAFE/training_feb2026/processed"
CLEAN_READS_DIR="/bigdata/pombubpalab/shared/FAILSAFE/training_feb2026/clean_reads"
ASSEMBLY_DIR="/bigdata/pombubpalab/shared/FAILSAFE/training_feb2026/assembly_results"
GENOME_DIR="/bigdata/pombubpalab/shared/FAILSAFE/Metagenome/BowtieIndices"
ASSEMBLER="megahit"  # Options: "megahit" or "metaspades"
```

Sample array or what is the name of the sample file
{:.left}
```bash
# Sample array
SAMPLES=(
    "Unknown_CO884-001R0001"
    "Unknown_CO884-001R0002"
    "Unknown_CO884-001R0003"
)
```

