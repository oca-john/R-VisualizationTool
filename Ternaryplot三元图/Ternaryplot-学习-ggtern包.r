# Ternaryplot-学习-ggtern包

## ggtern包安装
没有安装ggtern包的可以先通过install.packages("ggtern")安装
```
library(ggtern)
data=read.table("test.tsv",header=T,check.names=F,sep=" ",quote="",dec=".")
# 默认参数绘图
ggtern(data=data,aes(x=AE,y=AO,z=AT))+geom_point()
```

## 绘图，并参数调整
我们可以通过调整一些参数来修改点的形状，颜色，大小，并增加图例和标题。
```
ggtern(data=data,aes(x=AE,y=AO,z=AT,
shape=group,                  #点的形状参数
color=group ) ) +             #颜色参数
theme_rgbw( ) +               #绘图主题设置，可以通过 ?theme_bw 查看其他主题
geom_point(size=5) +        
theme_legend_position("topright") +   #图例位置参数
labs(title = "Example")       #标题
```

## 散点统一为圆形
修改以上参数后，我们就可以得到具有分组信息、图例、标题的三元图（图2-1），比原来的图能表达更多的信息。
如果需要统一点的形状，
可以调整geom_point中的参数（图2-2）：
```
geom_point(aes(fill=group),   #按照group列来填充颜色
     size=6,                  #点的大小
     shape=21,                #点的形状（shape=21为空心的圆形）
     color='gray')            #点的颜色
```
