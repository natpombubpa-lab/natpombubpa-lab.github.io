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

Practice question 1: What does the command ```ls``` do when using with ```-l``` and ```-h``` flags?


Check files in other directory using ```ls Directory_name```, you will see that there are four items in ```unix_intro``` folder.

{:.left}
```bash

[/home/jovyan]$ ls unix_intro/
data  example.txt  experiment  six_commands

```

Now, we know which directory we want to work with, let's change working directory using ```cd``` command.

{:.left}
```bash

[/home/jovyan]$ cd unix_intro/
[/home/jovyan/unix_intro]$ 

```

Now we know how to go down directory, how do we go up/back?

{:.left}
```bash

[/home/jovyan/unix_intro]$ cd jovyan
bash: cd: jovyan: No such file or directory

```
To take us back to parent directory, we do ```cd ..```, let's try

{:.left}
```bash

[/home/jovyan/unix_intro]$ cd ..
[/home/jovyan]$ 

```

We can also use a path to change directory.

{:.left}
```bash

[/home/jovyan]$ cd unix_intro/experiment/
[/home/jovyan/unix_intro/experiment]$

```

Change to home directory in one command, ```cd```

{:.left}
```bash

[/home/jovyan/unix_intro/experiment]$ cd
[/home/jovyan]$ 

```

### Unix concept 2: Working with files
We know how to navigate files, how can we create, copy, or delete files? 
Let's make sure we start at ```unix_intro``` folder and take a look at what we have in this folder using ```ls -F```.

{:.left}
```bash

[/home/jovyan]$ cd unix_intro/
[/home/jovyan/unix_intro]$ pwd
/home/jovyan/unix_intro
[/home/jovyan/unix_intro]$ ls -F
data/  example.txt  experiment/  six_commands/

```

Currently, there are three directories/folders, to create a new directory, we will use ```mkdir``` command.

{:.left}
```bash
[/home/jovyan/unix_intro]$ mkdir Thesis
```

Check if you have ```Thesis``` directory, there should be five items in your ```unix_intro``` directory.

{:.left}
```bash
[/home/jovyan/unix_intro]$ ls -F
data/  example.txt  experiment/  six_commands/  Thesis/
```

Note for naming files and directiries: 1) don't use whitespaces, 2) don't begin with ```-``` (dash), 3) stick with letters, numbers, ```.``` (period or full stop), ```-``` (dash), and ```_``` (underscore). [Referent to swcarpentry](swcarpentry.github.io)


Now, change working directory to ```Thesis``` and we will create a file called ```draft.txt``` using ```nano``` command.

{:.left}
```bash

[/home/jovyan/unix_intro]$ cd Thesis/
[/home/jovyan/unix_intro/Thesis]$ nano draft.txt

```

Once you open up ```nano``` it will look like a picture below. Let's write a sentence into your file. Press Ctrl+O to save file, then enter to accpet changes you made, To exit from nano, press Ctrl + X

![Nano](https://natpombubpa-lab.github.io/images/tools/Unix/unix_1.3.png){:class="img-responsive"}

Check for ```draft.txt``` in your ```Thesis``` directory

{:.left}
```bash

[/home/jovyan/unix_intro/Thesis]$ ls -lh
total 4.0K
-rw-r--r-- 1 jovyan jovyan 18 Jan 16 20:48 draft.txt

```

Create a file without nano using ```touch``` command, let's try

{:.left}
```bash

[[/home/jovyan/unix_intro/Thesis]$ touch my_file.txt

```

Practice question 2: What did the touch command do? When you look at your home directory using the GUI file explorer, does the file show up?

Preactice question 3: Try using ```ls -l``` to inpsec the files, do you see any different between ```draft.txt``` and ```my_file.txt```?

