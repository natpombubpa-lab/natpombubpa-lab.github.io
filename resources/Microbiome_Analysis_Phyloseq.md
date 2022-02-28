---
title: Phyloseq: Microbiome Analysis Tutorial
image: AMPtk.jpg
---

# Phyloseq: Basic Microbiome Analysis Tutorial

This tutorial will go over [Phyloseq](https://joey711.github.io/phyloseq/index.html) which further analyse data generated from [a basic microbiome analysis tutorial using AMPtk pipeline](https://natpombubpa-lab.github.io/resources/Microbiome_Analysis). This SOP/tutorial includes 1) Alpha diversity analysis, 2) Taxonomy barplot, and 3) Beta Doversity analysis. This tutorial dose not require installation, you can simply click [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/natpombubpa-lab/Rbinder-phyloseq/v5?urlpath=rstudio) and your browser will bring up everything you need for this tutorial. 


บทเรียนนี้จะสอนการใช้ [Phyloseq](https://joey711.github.io/phyloseq/index.html) เบื้องต้นเพื่อวิเคราะห์ข้อมูลที่ได้จาก [การวิเคราะห์ข้อมูลความหลากหลายของจุลินทรีย์(ไมโครไบโอม)เบื้องต้น](https://natpombubpa-lab.github.io/resources/Microbiome_Analysis) โดยผู้เรียนไม่ต้องดาวน์โหลดโปรแกรมลงบนคอมพิวเตอร์ส่วนตัว เพียงคลิกที่ [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/natpombubpa-lab/Rbinder-phyloseq/v5?urlpath=rstudio) ข้อมูลและโปรแกรมจะเปิดขึ้นมาบนหน้าเว็บ และ พร้อมใช้งานได้ทันที (หมายเหตุ: หากมีผู้ใช้งานจำนวนมาก อาจใช้เวลามากกว่า 10 นาทีในการเปิดหน้าเว็บ) การวิเคราะห์ข้อมูลไมโครไบโอมโดยการมช้ Phyloseq ที่จะกล่าวถึงนั้น มี 3 ส่วน คือ Alpha diversity analysis, 2) Taxonomy barplot และ 3) Beta Doversity analysis

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

## Step A: Open Binder to launch RStudio

![Landing Page](https://user-images.githubusercontent.com/54328862/133711607-79fb884e-1804-4cb3-b4cc-be0a7ecf7a5c.png){:class="img-responsive"}

Once you click on [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/natpombubpa-lab/Rbinder-phyloseq/v5?urlpath=rstudio), your web browser should bring up a similar RStudio as the picture shown above.
