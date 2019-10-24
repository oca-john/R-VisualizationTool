# Ternaryplot-学习-vcd包

## 准备工作
通过install.packages("vcd")安装vcd包
```
data=read.table("test.tsv",header=T,check.names=F,sep=" ",quote="",dec=".")             #读取数据
mycolor<-c("#46DCBE","#F08080","#FFA500","gray") 
group<-data[,"group"]       
color<-mycolor[as.numeric(group)]       #按照分组设置颜色

## 绘图
```
library(vcd)
ternaryplot(
    data[,2:4],           #用于绘图的三列数据
    pch = 20,             #点的形状
    col = color,          #点的颜色
    main = "Example",     #标题
    labels = "outside",   #标签的位置
    grid = "dashed",      #网格的形式
    grid_color="gray",    #网格的颜色
    border="black",       #边界的颜色
    bg="white",           #背景颜色
    cex =2,               #点的大小
    prop_size = 5)        #点的大小与变量成比例绘制（当prop_size参数为TRUE时，自动忽略cex参数）
grid_legend("topright", pch=20, col=mycolor, labels=levels(group),  title = "group")    #图例参数
```
