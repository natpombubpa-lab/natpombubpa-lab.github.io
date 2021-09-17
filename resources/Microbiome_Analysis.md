---
title: Microbiome Analysis Tutorial
image: AMPtk.jpg
---

# Basic Microbiome Analysis Tutorial

This is a basic microbiome analysis tutorial using AMPtk pipeline. This SOP/tutorial includes 1) processing raw sequence data files, 2) clustering/denoising sequences, and 3) taxonomy assignment. This tutorial dose not require installation, you can simply click [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Amptk_v1.4.2/main?urlpath=lab) and your browser will bring up everything you need for this tutorial. 


เว็บเพจนี้สอนวิธีการวิเคราะห์ข้อมูลความหลากหลายของจุลินทรีย์(ไมโครไบโอม)เบื้องต้น โดยผู้เรียนไม่ต้องดาวน์โหลดโปรแกรมลงบนคอมพิวเตอร์ส่วนตัว เพียงคลิกที่ [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Amptk_v1.4.2/main?urlpath=lab) ข้อมูลและโปรแกรมจะเปิดขึ้นมาบนหน้าเว็บ และ พร้อมใช้งานได้ทันที (หมายเหตุ: หากมีผู้ใช้งานจำนวนมาก อาจใช้เวลามากกว่า 10 นาทีในการเปิดหน้าเว็บ) การวิเคราะห์ข้อมูลไมโครไบโอมเบื้องต้นที่จะกล่าวถึงนั้น มี 3 ขั้นตอนหลัก คือ 1) processing raw sequence data files, 2) clustering/denoising sequences, และ 3) taxonomy assignment.

<style>
pre {
  font-family: Consolas,"courier new";
  width: 1188px;
  color: lightgreen;
  float: left;
  background-color: #0a0101;
  padding: 18px;
  font-size: 100%;
}
</style>

## Step A: Open Binder and Launch Terminal

![Landing Page](https://user-images.githubusercontent.com/54328862/133711607-79fb884e-1804-4cb3-b4cc-be0a7ecf7a5c.png){:class="img-responsive"}

Once you click on [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Amptk_v1.4.2/main?urlpath=lab), your web browser should bring up a similar window as the picture shown above. The next step is to click "Terminal" which should look like a picture below after you click on it.

![Terminal](https://user-images.githubusercontent.com/54328862/133711667-3be45824-8f87-4163-978a-db4cfd667023.png){:class="img-responsive"}

Let's make sure that you have all data needed for this tutorial.

{:.left}
```bash
# when you type "ls", you should have 4 files and 2 folders
# if you don't have these, something probably went wrong 
# you will need to re-launch the binder 

[/home/jovyan]$ ls
apt.txt  bin  environment.yml  illumina  postBuild  README.md

```


## Step B: Analysis set up

Next step is to verify that AMPtk can be used.

{:.left}
```bash
# simply type "amptk", amptk manual page should show up.
# amptk manual page is longer than this, 
# but I only show you the first few lines.

[/home/jovyan]$ amptk

Usage:       amptk <command> <arguments>
version:     1.4.2
```

If everything work perfectly for you, you are almost ready for the actual analysis. There is only one more step. AMPtk requires usearch9 which can be download from [here](https://drive5.com/downloads/usearch9.2.64_i86linux32.gz).  

{:.left}
```bash
# 1. change directory to "bin" folder
# 2. once you are in "bin" folder, simply use curl to download usearch9 for your own personal use to follow this tutorial
# 3. unzip the file 
# 4. make usearch9 executable
# when you are done with these step, change back to home directory

[/home/jovyan]$ cd bin/
[/home/jovyan/bin]$ curl -o usearch9.gz "https://drive5.com/downloads/usearch9.2.64_i86linux32.gz"
[/home/jovyan/bin]$ gunzip usearch9.gz
[/home/jovyan/bin]$ chmod +x usearch9
[/home/jovyan/bin]$ cd ..
[/home/jovyan]$

```

## Step 1: Pre-processing

We will use [AMPtk](https://amptk.readthedocs.io/en/latest/index.html) to process amplicon data.

We can get this data from a public dataset stored in NCBI. First let's look at the BioProject page [PRJNA659596](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA659596). This page provides links to the 256 SRA experiments for 16S and ITS amplicon data from ["Belowground Impacts of Alpine Woody Encroachment are determined by Plant Traits, Local Climate and Soil Conditions"](https://onlinelibrary.wiley.com/doi/full/10.1111/gcb.15340?casa_token=F44K1LXM-S8AAAAA%3A7mludBZ8DZfAoJvs3XG_hM_FqV1LcvEj_ZIZbqBjEkgdxgfwOIWn6gqCARK_AcWB8F_5ATcKzDJ6ZDk) project.

Although, this study has both 16S and ITS amplicon data, we will perform data processing only on several samples from ITS data.

<img width="1100" alt="primer_setup" src="https://user-images.githubusercontent.com/54328862/95925094-c86b3e80-0d6d-11eb-964a-1f3b5f30130e.png">
More detials on Sequencing setup can be found [here](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0090234#)

ITS primers for this project contain unique barcode for each sample. We usually submit ~200 samples per illumina miseq run. After sequencing process, the barcodes will be used to split sequences into fastq file for each sample.

Before we begin Pre-processing data, let's take a look at our data.

{:.left}
```bash
#All data are in illunmina folder 
#You should have 22 fastq files in this folder

[/home/jovyan]$ ls illumina/
ITS-cc-121_S26_L001_R1_001.fastq.gz   ITS-cc-21_S123_L001_R2_001.fastq.gz
ITS-cc-121_S26_L001_R2_001.fastq.gz   ITS-cc-221_S136_L001_R1_001.fastq.gz
ITS-cc-212_S126_L001_R1_001.fastq.gz  ITS-cc-221_S136_L001_R2_001.fastq.gz
ITS-cc-212_S126_L001_R2_001.fastq.gz  ITS-cc-27_S156_L001_R1_001.fastq.gz
ITS-cc-213_S127_L001_R1_001.fastq.gz  ITS-cc-27_S156_L001_R2_001.fastq.gz
ITS-cc-213_S127_L001_R2_001.fastq.gz  ITS-cc-76_S210_L001_R1_001.fastq.gz
ITS-cc-216_S130_L001_R1_001.fastq.gz  ITS-cc-76_S210_L001_R2_001.fastq.gz
ITS-cc-216_S130_L001_R2_001.fastq.gz  ITS-cc-91_S227_L001_R1_001.fastq.gz
ITS-cc-217_S131_L001_R1_001.fastq.gz  ITS-cc-91_S227_L001_R2_001.fastq.gz
ITS-cc-217_S131_L001_R2_001.fastq.gz  ITS-cc-98_S234_L001_R1_001.fastq.gz
ITS-cc-21_S123_L001_R1_001.fastq.gz   ITS-cc-98_S234_L001_R2_001.fastq.gz

```

What does the sequence file look like?

{:.left}
```bash

[/home/jovyan]$ zmore illumina/ITS-cc-121_S26_L001_R1_001.fastq.gz | head -2
@M02457:311:000000000-C6VB2:1:1101:18927:1862 1:N:0:ATGTCCAG+CAGTCGGA
AGCCTCCGCTTATTGATATGCTTAAGTTCAGCGGGTGGTCCTACCTGATTTGAGGTCAGAGTCCAAAAGAGCGCCACAAGGGGCAGGTTATGAGCGGGCCTCACACCATGCCAGACGAAACTTATCACGTCAGGACGTGGATGCTGGTCCCACTAAGTCATTTGAGGCAAGCCGGCAGACGGCAGACACCCAGGTCCATGTCCACCCCAGGTCAAGGAGACCCGAGGGGATTGAGATTTCATGACACTCAAACAGGCATGCCTTTCGGAATACCAAAAGGCGCAAGGTGCGTTCGAAGATT

```

Now, we can begin Pre-processing steps, BUT......!!!

There are several different file format that could be generated from Illumina Miseq sequencing (or sequencing centers). We’ll focus on demultiplexed PE reads in whcih all the sequences were splited into separated fastq files for each samples. The general workflow for Illumina demultiplexed PE reads is:
- Merge PE reads (use USEARCH or VSEARCH)
- filter reads that are phiX (USEARCH)
- find forward and reverse primers (pay attention to –require_primer argument)
- remove (trim) primer sequences
- if sequence is longer than –trim_len, truncate sequence

<img width="1100" alt="MergedPEreads" src="https://user-images.githubusercontent.com/54328862/133710923-38f4432c-6ff1-4e29-860e-b5b4255308b3.gif">

{:.left}
```bash
#Pre-preocessing steps will use `amptk illumia` command for demultiplexed PE reads

[/home/jovyan]$ amptk illumina -i illumina/ --merge_method vsearch\
                -f AACTTTYRRCAAYGGATCWCT -r AGCCTCCGCTTATTGATATGCTTAART\
                --require_primer off -o DetMyco --usearch usearch9\
                --rescue_forward on --primer_mismatch 2 -l 250

```

## Step 2: Clustering

<img width="1100" alt="Clustering" src="https://user-images.githubusercontent.com/54328862/133711204-956c9f50-3e3f-4d94-83a8-3a771ae66216.jpg">

This step will cluster sequences into Operational Taxonomy Unit (OTU), then generate representative OTU sequences and OTU table. OTU generation pipelines in AMPtk uses UPARSE clustering with 97% similarity (this can be changed).

Note: at clustering step, we used merged sequence from STEP1 as an input and we will generate clustered sequences file and OTU table.

{:.left}
```bash

[/home/jovyan]$ amptk cluster -i DetMyco.demux.fq.gz -o DetMyco\
                --usearch usearch9 --map_filtered -e 0.9

```

Checking OTU table

{:.left}
```bash

To be added

```


## Step 3: Taxonomy assignment

This step will assign taxonomy to each OTU sequence and add taxonomy to OTU table. This command will generate taxnomy based on the ITS database.

Note: at Taxonomy Assignment step, we will use clustered sequences file and OTU table for taxonomy assignment from ITS database

{:.left}
```bash

[/home/jovyan]$ amptk taxonomy -f DetMyco.cluster.otus.fa -i DetMyco.otu_table.txt -d ITS

```

When the taxonomy assignment is completed, we can check the taxonmy file.

{:.left}
```bash

To be added

```


## Step 6: Summarizing our results

Let's take a look at our results summary.

{:.left}
```bash

[/home/jovyan]$ amptk summarize -i DetMyco.cluster.otu_table.taxonomy.txt \
                --graphs -o test --font_size 6 --format pdf --percent

```

### References

- [AMPtk](https://amptk.readthedocs.io/en/latest/index.html)
- [usearch9](https://drive5.com/downloads/usearch9.2.64_i86linux32.gz)
