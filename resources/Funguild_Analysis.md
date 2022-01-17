---
title: Fungi functional guild analysis
image: FUNGuild_analysis.jpg
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

[FUNGuild](https://www.sciencedirect.com/science/article/pii/S1754504815000847): An open annotation tool for parsing fungal community datasets by ecological guild. 

Once we identify fungal taxonomy/species, the next step that would be crucial for microbial ecology is to learn about fungal ecologyical functions. Our example data were generated using [FUNGuild](https://www.sciencedirect.com/science/article/pii/S1754504815000847) which annotate fungal function to each species in our dataset. Today, we will learn how to perform FUNGuild analysis.

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

## Step 2: Now, let's perform FUNGuild annotation which requires two steps.

### 2.1 Using a taxa parser to extract taxonomic information from an OTU table

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

### 2.2 Using a guild parser to query the FUNGuild database
Currently (as of Jan 17, 2022), code in ```FUNGuild.py``` needs to be updated to solve FUNGuild database connection issue. You can fix the code by adding ```www.``` before ```mycoportal.org``` on line 148 in ```FUNGuild.py``` If you are using nano, ```nano -c FUNGuild.py``` can help identifying line 148.

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

### 2.3 Let's take a look at our fungi functional guild results

{:.left}
```bash

[/home/jovyan/FUNGuild]$ awk '{print $1" "$11}' example/otu_table.taxa.guilds.txt 
OTU trophicMode
OTU_100 Pathotroph
OTU_1002 Symbiotroph
OTU_1003 na
OTU_1008 Saprotroph-Symbiotroph
OTU_1011 Symbiotroph
OTU_1015 na
OTU_1018 na
OTU_1021 Pathotroph-Saprotroph
OTU_1023 Symbiotroph
OTU_1024 na

```
