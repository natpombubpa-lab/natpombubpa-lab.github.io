---
title: Microbiome Analysis Tutorial
image: AMPtk.jpg
---



This is a basic microbiome analysis tutorial using AMPtk pipeline. This SOP/tutorial includes 1) processing raw sequence data files, 2) clustering/denoising sequences, 3) filtering, and 4) taxonomy assignment. Two additional steps including funtional guild assignment and how to combine all the steps into a single bash script are also provided. This tutorial dose not require installation, you can simply click [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Amptk_v1.4.2/main?urlpath=lab) and your browser will bring up everything you need for this tutorial. 


เว็บเพจนี้สอนวิธีการวิเคราะห์ข้อมูลความหลากหลายของจุลินทรีย์(ไมโครไบโอม)เบื้องต้น โดยผู้เรียนไม่ต้องดาวน์โหลดโปรแกรมลงบนคอมพิวเตอร์ส่วนตัว เพียงคลิกที่ [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Amptk_v1.4.2/main?urlpath=lab) ข้อมูลและโปรแกรมจะเปิดขึ้นมาบนหน้าเว็บ และ พร้อมใช้งานได้ทันที (หมายเหตุ: หากมีผู้ใช้งานจำนวนมาก อาจใช้เวลามากกว่า 10 นาทีในการเปิดหน้าเว็บ) การวิเคราะห์ข้อมูลไมโครไบโอมเบื้องต้นที่จะกล่าวถึงนั้น มี 4 ขั้นตอนหลัก คือ 1) processing raw sequence data files, 2) clustering/denoising sequences, 3) filtering, และ 4) taxonomy assignment. หลังจากนั้น เราสามารถวิเคราะห์เพิ่มเติมเกี่ยวกับ Functional guilds และ การรวบรวมทุกขั้นตอนไว้ใน shell script

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

## Step 1: Open Binder and Launch Terminal

![Landing Page](https://user-images.githubusercontent.com/54328862/95927664-3fa3d100-0d74-11eb-9609-c2ca587c86b7.png){:class="img-responsive"}

Once you click on [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Amptk_v1.4.2/main?urlpath=lab), your web browser should bring up a similar window as the picture shown above. The next step is to click "Terminal" which should look like a picture below after you click on it.

![Terminal](https://user-images.githubusercontent.com/54328862/95927852-cc4e8f00-0d74-11eb-9f22-febe7cdae98d.png){:class="img-responsive"}

Let's make sure that you have all data needed for this tutorial.

{:.left}
```bash
# when you type "ls", you should have 4 files and 2 folders
# if you don't have these, something probably went wrong 
# you will need to re-launch the binder 

[/home/jovyan]$ ls
apt.txt  bin  environment.yml  illumina  postBuild  README.md

```


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

If everything work perfectly for you, you are almost ready for the actual analysis. There is only one more step.

AMPtk requires usearch9 which can be download from [here](https://drive5.com/downloads/usearch9.2.64_i86linux32.gz).  

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

## Step 2: Analysis set up

We will use [AMPtk](https://amptk.readthedocs.io/en/latest/index.html) to process amplicon data.

We can get this data from a public dataset stored in NCBI. First let's look at the BioProject page [PRJNA659596](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA659596). This page provides links to the 256 SRA experiments for 16S and ITS amplicon data from ["Belowground Impacts of Alpine Woody Encroachment are determined by Plant Traits, Local Climate and Soil Conditions"](https://onlinelibrary.wiley.com/doi/full/10.1111/gcb.15340?casa_token=F44K1LXM-S8AAAAA%3A7mludBZ8DZfAoJvs3XG_hM_FqV1LcvEj_ZIZbqBjEkgdxgfwOIWn6gqCARK_AcWB8F_5ATcKzDJ6ZDk) project.

Although, this study has both 16S and ITS amplicon data, we will perform data processing only on several samples from ITS data.

<img width="1100" alt="primer_setup" src="https://user-images.githubusercontent.com/54328862/95925094-c86b3e80-0d6d-11eb-964a-1f3b5f30130e.png">
More detials on Sequencing setup can be found [here](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0090234#)

ITS primers for this project contain unique barcode for each sample. We usually submit ~200 samples per illumina miseq run. After sequencing process, the barcodes will be used to split sequences into fastq file for each sample.


### References


