---
title: Qiime2 Analysis Tutorial
image: phyloseq.png
---

# Qiime2 Analysis Tutorial

This tutorial will go over [Qiime2](https://qiime2.org/). This tutorial dose not require installation, you can simply click [![Binder](http://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Qiime2_2022.8_binder/master) and your browser will bring up everything you need for this tutorial. 

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

## Step A: Open Binder to launch Qiime

## Set timezone

{:.left}
```
export TZ='Europe/London'
```


## Download data

{:.left}
```
mkdir qiime2-moving-pictures-tutorial
cd qiime2-moving-pictures-tutorial
```

{:.left}
```
wget \
  -O "sample-metadata.tsv" \
  "https://data.qiime2.org/2022.11/tutorials/moving-pictures/sample_metadata.tsv"
```

{:.left}
```
mkdir emp-single-end-sequences
```

{:.left}
```
wget \
  -O "emp-single-end-sequences/barcodes.fastq.gz" \
  "https://data.qiime2.org/2022.11/tutorials/moving-pictures/emp-single-end-sequences/barcodes.fastq.gz"
```

{:.left}
```
wget \
  -O "emp-single-end-sequences/sequences.fastq.gz" \
  "https://data.qiime2.org/2022.11/tutorials/moving-pictures/emp-single-end-sequences/sequences.fastq.gz"
```

{:.left}
```
wget \
  -O "gg-13-8-99-515-806-nb-classifier.qza" \
  "https://data.qiime2.org/2022.11/common/gg-13-8-99-515-806-nb-classifier.qza"
```
