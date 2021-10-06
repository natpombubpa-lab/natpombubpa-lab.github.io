---
title: Fungi functional guild plot
image: AMPtk.jpg
---

# Fungi functional guild (FunGuild) plot

This is a basic Fungi functional guild (FUNGuild) plot tutorial. This tutorial dose not require installation, you can simply click [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Amptk_v1.4.2/main?urlpath=lab) and your browser will bring up everything you need for this tutorial. 


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

If everything work perfectly for you, you are ready for the actual analysis. 

## Step 1: Downloding example data

{:.left}
```bash

#Download FUNGuild example data
[/home/jovyan]$ wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=1o7RRnZdm_dn27HGAIgT6tLUq0QqD8Cw2'

#Rename example data filename
[/home/jovyan]$ mv uc\?export\=download\&id\=1o7RRnZdm_dn27HGAIgT6tLUq0QqD8Cw2 FUNGuild_example.txt

```

## Step 2: Downloding example mapping file

{:.left}
```bash

#Download example mapping file
[/home/jovyan]$ wget --no-check-certificate 'https://drive.google.com/uc?export=download&id=10_t6JJBozHvfCG445Z-PyCQYaC5ZWj2R'

#Rename example mapping file filename
[/home/jovyan]$ mv uc\?export\=download\&id\=10_t6JJBozHvfCG445Z-PyCQYaC5ZWj2R mapping_File.txt

```
Now, you should have ```mapping_File.txt``` and ```FUNGuild_example.txt``` in your folder

{:.left}
```bash

#Check your files
[/home/jovyan]$ ls
apt.txt  environment.yml       illumina          postBuild
bin      FUNGuild_example.txt  mapping_File.txt  README.md

```

## Step 3: Preprocessing step
Oftentime, bioinformatic processes begin with preprocessing step or reformatiing your files. In this example, our sample name in ```mapping_File.txt``` and ```FUNGuild_example.txt``` do not match. Therefore, we will change sample names in ```FUNGuild_example.txt``` to match sample names in our ```mapping_File.txt```.

{:.left}
```bash

#Check original sample names in FUNGuild_example.txt
[/home/jovyan]$ head -1 FUNGuild_example.txt 
#OTU ID GMT-CLC GMT-CLC-SUB     GMT-GLC GMT-GLC-SUB     TaxonomyTaxon    Taxon Level     Trophic Mode    Guild   Confidence Ranking

#Change sample names in file
[/home/jovyan]$ sed '1s/-/\./g' FUNGuild_example.txt > FUNGuild_example_fix.txt

#Check new sample names in FUNGuild_example.txt
[/home/jovyan]$ head -1 FUNGuild_example_fix.txt 
#OTU ID GMT.CLC GMT.CLC.SUB     GMT.GLC GMT.GLC.SUB     TaxonomyTaxon    Taxon Level     Trophic Mode    Guild   Confidence Ranking    Growth Morphology       Trait   Notes   Citation/Source

```



## Step 6: Summarizing our results

Let's take a look at our results summary.

{:.left}
```bash

[/home/jovyan]$ amptk summarize -i DetMyco.cluster.otu_table.taxonomy.txt \
                --graphs -o DetMyco --font_size 6 --format pdf --percent

```

<img width="1100" alt="Taxonomy_summary" src="https://user-images.githubusercontent.com/54328862/133716147-5d3ec766-dc98-4826-a265-d2b6a6a6a052.png">

### References

- [FUNGuild](https://github.com/UMNFuN/FUNGuild)

