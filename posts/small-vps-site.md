---
title: Scraping by with a 128mb VPS
tags: vps, memory limits, webapp
date: 4/20/2013
---


#### Getting along with a tiny VPS
At the moment (April 18th) this site is running on a 128mb vps from frantech 
and hovering right on the edge of the memory limit.

![128 days uptime](/imgs/_posts/htop-memory.png)

You can see it perpetually in burst memory, but it never goes above 110. The only things running on this server are irssi and this 1 node.js website. 

<!--more-->

I'd be curious if anyone else is running minimal sites on a small vps. If I had a 256 box I'd bust out mongo... however, mongo puts this lil' guy over by about 60mb memory so if I ever _really_ need a db for this site it'll have to go on an ec2 instance or I'll have to upgrade.

#### Network Load Times
I took a look at load times with firebug as well. It seems I should do something about fancybox because the large image shouldn't be loaded right away but even after cache there seems to be some bottlenecks.

__Load times with large images no cache__
![with images](/imgs/_posts/no-cache-load.png)
__Load times with large images after cache__
![without images](/imgs/_posts/cache-load.png)

__Edit:__ I did something about fancybox.. I used it properly and made preview images. Yay me. Derp

__Note:__ The load times are longer than normal because of my terrible home wifi (fuck you comcast) but I'm more interested in the difference between the 2 times and looking at what I can do better.

