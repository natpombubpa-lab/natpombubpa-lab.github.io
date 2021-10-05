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

## Step 1: Dowloding example data

```bash

[/home/jovyan]$ curl

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

