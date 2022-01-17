---
title: Basic Unix for Biologists (EP1)
image: AMPtk.jpg
---
Basic Unix for Biologists is aiming to helps anyone who would like to learn basic unix programming. This introduction/tutorial dose not require installation, you can simply click [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Intro_Unix/master?urlpath=lab) and your browser will bring up everything you need for this tutorial. Basic Unix for Biologists (EP1) will show you how this tutorial is setup and also introduce you to unix shell programming which will prepare you for Basic Unix for Biologists (EP2.)


เว็บเพจนี้สอน Unix Shell เบื้องต้น โดยผู้เรียนไม่ต้องดาวน์โหลดโปรแกรมลงบนคอมพิวเตอร์ส่วนตัว เพียงคลิกที่ [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Intro_Unix/master?urlpath=lab) ข้อมูลและโปรแกรมจะเปิดขึ้นมาบนหน้าเว็บ และ พร้อมใช้งานได้ทันที (หมายเหตุ: หากมีผู้ใช้งานจำนวนมาก อาจใช้เวลามากกว่า 10 นาทีในการเปิดหน้าเว็บ) Basic Unix for Biologists (ตอนที่ 1) จะเริ่มต้นกล่าวถึงองค์ประกอบของข้อมูลที่จะใช้ในการเรียน Basic Unix for Biologists และแนะนำเกี่ยวกับ Unix Shell เบื้องต้น เพื่อเตรียมความพร้อมสำหรับ Basic Unix for Biologists (ตอนที่ 2)

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

## Open Binder and Launch Terminal

![Landing Page](https://natpombubpa-lab.github.io/images/tools/Unix/unix_1.1.png){:class="img-responsive"}

Once you click on [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/NatPombubpa/Binder_Intro_Unix/master?urlpath=lab), your web browser should bring up a similar window as the picture shown above. The next step is to click "Terminal" which should look like a picture below after you click on it.

![Terminal](https://natpombubpa-lab.github.io/images/tools/Unix/unix_1.2.png){:class="img-responsive"}

If everything work perfectly for you, you are ready for the tutorial. 

## What can a computer do simple term?
Naigate files, run programs/applications, store data, interact with users etc.
- Graphical user interface (GUI): users can see files, folders, etc. graphically (on the left of your binder)
- Command-line interdaces (CLI): users interact with computer via command line (Terminal on the right of your binder)

If we are using GUI with too many clicks, we can use CLI to help us. 

### Unix concept 1: Navigating files
To find out where we are, we can use ```pwd``` to print out current working directory.

{:.left}
```bash

[/home/jovyan]$ pwd
/home/jovyan

```

Check files in the current directory (current folder) using ```ls``` command (listing). You should have four items in your current directory as shown below. 

{:.left}
```bash

[/home/jovyan]$ ls
apt.txt  data-shell  README.md  unix_intro

```

If you want to annotate folders when using ```ls``` command, we can use a flag ```ls -F``` is listing with flag-F to indicate directory/folder.

{:.left}
```bash

[/home/jovyan]$ ls -F
apt.txt  data-shell/  README.md  unix_intro/

```

Practice 1: What does the command ```ls``` do when using with ```-l``` and ```-h``` flags?


