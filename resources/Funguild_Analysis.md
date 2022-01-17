---
title: Fungi functional guild analysis
image: AMPtk.jpg
---

# Fungi functional guild (FunGuild) analysis

This is a basic Fungi functional guild (FUNGuild) analysis tutorial. This tutorial dose not require installation on your system, you can simply click [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Amptk_v1.4.2/main?urlpath=lab) and your browser will bring up everything you need for this tutorial. 


เว็บเพจนี้สอนวิธีการวิเคราะห์ข้อมูล Fungi functional guild (FUNGuild) เบื้องต้น โดยผู้เรียนไม่ต้องดาวน์โหลดโปรแกรมลงบนคอมพิวเตอร์ส่วนตัว เพียงคลิกที่ [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Amptk_v1.4.2/main?urlpath=lab) ข้อมูลและโปรแกรมจะเปิดขึ้นมาบนหน้าเว็บ และ พร้อมใช้งานได้ทันที (หมายเหตุ: หากมีผู้ใช้งานจำนวนมาก อาจใช้เวลามากกว่า 10 นาทีในการเปิดหน้าเว็บ)

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

If everything work perfectly for you, you are almost ready for the actual analysis. 

## Step 1: Download FunGuild program

Using ```git clone``` to download FunGuild

{:.left}
```bash

#Download FUNGuild 
[/home/jovyan]$ git clone https://github.com/UMNFuN/FUNGuild

```

Then, press enter to start downloading process

{:.left}
```bash

#Download FUNGuild 
[/home/jovyan]$ git clone https://github.com/UMNFuN/FUNGuild
Cloning into 'FUNGuild'...
remote: Enumerating objects: 501, done.
remote: Counting objects: 100% (41/41), done.
remote: Compressing objects: 100% (31/31), done.
remote: Total 501 (delta 20), reused 24 (delta 9), pack-reused 460
Receiving objects: 100% (501/501), 1.05 MiB | 7.15 MiB/s, done.
Resolving deltas: 100% (290/290), done.

```

When this step completes, FUNGuild folder should appear. Using ```ls``` command to see your folder.

{:.left}
```bash

[/home/jovyan]$ ls
apt.txt  bin  environment.yml  FUNGuild  illumina  postBuild  README.md

```

We will start with example data in FUNGuild folder. Change directory to FUNGuild folder and check your working directory. It should be ```/home/jovyan/FUNGuild```

{:.left}
```bash

[/home/jovyan]$ cd FUNGuild/
[/home/jovyan/FUNGuild]$ pwd
/home/jovyan/FUNGuild

```

Let's check what we have in FUNGuild folder using ```ls``` command

{:.left}
```bash

[/home/jovyan/FUNGuild]$ ls
example  FUNGuild_Manual.pdf  FUNGuild.py  Guilds_v1.0.py  Guilds_v1.1.py  README.md

```

Now, let's perform FUNGuild annotation which requires two steps.

### 1. Using a taxa parser to extract taxonomic information from an OTU table

{:.left}
```bash

[/home/jovyan/FUNGuild]$ python FUNGuild.py taxa -otu example/otu_table.txt -format tsv -column taxonomy -classifier unite

```

Then, press enter. At the end of this process we will have a taxonomy table for the actual FUNGuild annotation

{:.left}
```bash

[/home/jovyan/FUNGuild]$ python FUNGuild.py taxa -otu example/otu_table.txt -format tsv -column taxonomy -classifier unite
Taxa parser initiated.
Loading OTU table: example/otu_table.txt
Table format: tsv
Taxonomic column: taxonomy
Taxonomic style: unite
Parsed taxa file: example/otu_table.taxa.txt

```

### 2. Using a guild parser to query the FUNGuild database

{:.left}
```bash

[/home/jovyan/FUNGuild]$ python FUNGuild.py guild -taxa example/otu_table.taxa.txt

```

Then, press enter. At the end of this process we will have a FUNGuild table.

{:.left}
```bash

[/home/jovyan/FUNGuild]$ python FUNGuild.py guild -taxa example/otu_table.taxa.txt 
Guild parser initiated
Loading taxa file: example/otu_table.taxa.txt
Connecting with FUNGuild database ...
Found 11093 records in the db.
Search initiated.
Search finished.
FUNGuild results wrote to example/otu_table.taxa.guilds.txt.

```