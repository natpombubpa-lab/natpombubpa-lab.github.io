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

We will use ```R``` to generate FUNGuild plot, but ```R``` will skip a line that begins with ```#```. Our file header begin with ```#OTU```, therefore, we will need to change to ```OTU```. 

{:.left}
```bash

#Change header of FUNGuild_example_fix.txt
[/home/jovyan]$ sed '1s/#OTU/OTU/g' FUNGuild_example_fix.txt > FUNGuild_example_fix_header.txt

```


## Step 4: Creating Rscript for generating a plot

```bash

#Code for Rscript
library(ape)
library(vegan)
library(dplyr)
library(phyloseq)
library(ggplot2)
meta <- read.table("mapping_File.txt",header=TRUE,row.names=1,sep="\t",stringsAsFactors=FALSE)
sampleData <- sample_data(meta)
FG <- read.table("FUNGuild_example_fix_header.txt",header=T,sep="\t",row.names=1)
FGotus <- select(FG, -(Taxonomy:Citation.Source))
FGotumat <- as(as.matrix(FGotus), "matrix")
FGOTU <- otu_table(FGotumat, taxa_are_rows = TRUE)
FGtaxmat <- select(FG, Confidence.Ranking, Trophic.Mode, Guild, Growth.Morphology)
FGtaxmat <- as(as.matrix(FGtaxmat),"matrix")
FGTAX = tax_table(FGtaxmat)
physeq = phyloseq(FGOTU,FGTAX,sampleData)
physeq.prune = prune_taxa(taxa_sums(physeq) > 1, physeq)
physeq.prune.nopossible = subset_taxa(physeq.prune, Confidence.Ranking="Highly Possible")
physeq.prune.nopossible = subset_taxa(physeq.prune.nopossible, Confidence.Ranking!="-")
cbbPalette <- c("#009E73","#999999", "#E69F00", "#56B4E9", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "midnightblue", "lightgreen","saddlebrown", "brown", "aquamarine4","lavenderblush2","snow3", "darkblue", "darkgoldenrod1", "darkseagreen", "darkorchid", "darkolivegreen1", "black","lightskyblue", "darkgreen", "deeppink", "khaki2", "firebrick", "brown1", "darkorange1", "cyan1", "royalblue4", "darksalmon", "darkblue","royalblue4", "dodgerblue3", "steelblue1", "lightskyblue", "darkseagreen", "darkgoldenrod1", "darkseagreen", "darkorchid", "darkolivegreen1", "brown1", "darkorange1", "cyan1", "darkgrey")
FUNGuildcom = ggplot(data = psmelt(physeq.prune.nopossible), mapping = aes_string(x = "Sample" ,y = "Abundance", fill = "Trophic.Mode" )) + geom_bar(stat="identity", position="fill") + ggtitle("Fungal Trophic Mode Composition ")+theme(axis.text.x = element_text(angle = 90, hjust = 1)) + scale_fill_manual(values = cbbPalette)
pdf("./Fungal Trophic Mode Composition.pdf", width = 8, height = 5)
FUNGuildcom
dev.off()
pdf  

```

Copy codes from above and paste them while you open ```nano```

{:.left}
```bash

#Creating Rscript
[/home/jovyan]$ nano FUNGuild_plot.R 

```

## Step 5: Run Rscript to generate a plot summarizing our results

Let's take a look at our results summary.

{:.left}
```bash

[/home/jovyan]$ Rscript FUNGuild_plot.R

```

After the run is completed, you should see a PDF file in your current directory. Your result should be similar to the picture shown below.

<img width="1100" alt="FUNGuild_summary" src="https://user-images.githubusercontent.com/54328862/136133925-3b92dbe7-aae5-48ff-8eb1-74c3d485b429.png">

### References

- [FUNGuild](https://github.com/UMNFuN/FUNGuild)

