---
title: Qiime2 check
image: phyloseq.png
---

# Qiime2 setup check

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


## Everthing should be in this folder

{:.left}
```
qiime2-moving-pictures-tutorial
```

Theres should be 1 qza file, 1 tsv file, and emp-single-end-sequences folder.

{:.left}
```
home$ ls -ltr
total 55312
-rw-r--r--  1 nutpom  staff  28289645 Aug 31 04:24 gg-13-8-99-515-806-nb-classifier.qza
drwxr-xr-x  4 nutpom  staff       128 Jan 10 13:06 emp-single-end-sequences
-rw-r--r--  1 nutpom  staff      2094 Jan 25 12:57 sample-metadata.tsv
```

In emp-single-end-sequences,there should be 2 files.

{:.left}
```
home$ ls emp-single-end-sequences/
barcodes.fastq.gz	sequences.fastq.gz

```

If no qza file, download using the following link.

{:.left}
```
wget \
  -O "gg-13-8-99-515-806-nb-classifier.qza" \
  "https://data.qiime2.org/2022.11/common/gg-13-8-99-515-806-nb-classifier.qza"

```
