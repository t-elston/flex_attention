# flex_attention
code to assess how attention and valuation flexibly interact in primates

aaaFlexAttn_mega_v01.m is point of entry

a monkey was trained to choose between two compound stimuli on the basis of which attribute of the stimulus was currently relevant. On each trial, two (out of 8 possible) options were presented; some options were very valuable (+4 drops of juice) and some of low value (+1 drop of juice). These stimuli contained multiple attributes, which were faces and fruits. However, only one attribute (either faces or fruit) was relevant in a given block of trials. Thus, the animal first needed to determine which aspect of the compound stimuli predicted reward and then choose on the basis of that attribute. I implemented two kinds of switches - intra/extra-dimensional. Intra-dimesional shifts involved retaining the currently relevant attribute (e.g. fruit) but reversing the value hierarchies within that attribute. Extra-dimensional shifts involved changing which attribute of the compound stimuli was relevant (thus requiring the animal to flexibly update what he attends to). 

I found behavioral evidence of a dynamic interaction between attention and reinforcement learning systems. While this was very interesting, it wasn't the exact cognitive process I was aiming to electrophysiologically characterize and so this was shelved. This code is now archived but the orginal data is available in case of some cool modelling, etc. 

