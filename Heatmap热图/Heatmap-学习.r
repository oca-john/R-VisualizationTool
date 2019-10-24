# Heatmap - 学习

## 热图数据的转换
如果使用原始相对丰度或表达值，范围通常为0-100或0-1000000，而大部分的OTU或基因较低，做出的图会使绝大数据的数量颜色处于低丰度区，很难发现规律；因此需要数据变换，常用的方法有两类：  
- log2(x+1) , x为丰度或表达值
  - 为什么要原始值+1，是为了保证结果仍为正值，因为2的0次方为1；为什么要使用log变换，以log2为例，0-1000的表达范围，经变化为0-10的范围，颜色梯度范围更容易使人与数值建立对应关系。为什么常用log2对数变化，因为筛选差异的标准通常为两倍，log2对数变化后，每相差1的两个值都有两倍差异，选择目标很方便；有时也会根据具体情况，选择ln， log10等转换方式；
- Z-score标准化
  - 标准分数（standard score）也叫z分数（z-score）,是一个分数与平均数的差再除以标准差的过程。用公式表示为：z=(x-μ)/σ。其中x为某一具体分数，μ为平均数，σ为标准差。此种方法可以使有差异且稳定变化的两组明显区分为不同的颜色，但却丢失了原始相对丰度、差异倍数的信息。但由于结果比较美观，规律明显，使用较多。

## 常用工具
常用R的`heatmap`和`pheatmap`包；  
图形化的工具HEMI也可以绘制热图；  

## 方法1：生成格式化的测试数据
```
# 数据生成
data <- c(1:6,6:1,6:1,1:6, (6:1)/10,(1:6)/10,(1:6)/10,(6:1)/10,1:6,6:1,6:1,1:6, 6:1,1:6,1:6,6:1)
# 转为数据框
data <- as.data.frame(matrix(data, ncol=12, byrow=T))

# 增加列名
colnames(data) <- c("Zygote","2_cell","4_cell","8_cell","Morula","ICM","ESC","4 week PGC","7 week PGC","10 week PGC","17 week PGC", "OOcyte")
# 增加行名
rownames(data) <- paste("Gene", 1:8, sep="_")
```

### 方法2：读入字符串
```
# 将字串赋值给txt文件
> txt <- "ID;Zygote;2_cell;4_cell;8_cell
+ Gene_1;1;2;3;4
+ Gene_2;6;5;4;5
+ Gene_3;0.6;0.5;0.4;0.4"

# 读入文件的字符串内容
> data2 <- read.table(text=txt,sep=";", header=T, row.names=1, quote="")
```

### 方法3：从文件读入
```
> data2 <- read.table("filename",sep=";", header=T, row.names=1, quote="")
```

## 转换数据格式
```
# 安装包，载入包
install.packages(c("reshape2","ggplot2"))
library(reshape2)
library(ggplot2)

# 转换前，增加一列ID列保存行名
data$ID <- rownames(data)
# melt：把正常矩阵转换为长表格模式的函数。工作原理是把全部的非id列的数值列转为1列，命名为value；所有字符列转为variable列。
# id.vars 列用于指定哪些列为id列；这些列不会被merge，会保留为完整一列。
data_m <- melt(data, id.vars=c("ID"))
```

## 分解绘图
```
# aes: aesthetic的缩写，一般指定整体的X轴、Y轴、颜色、形状、大小等。
# 在最开始读入数据时，一般只指定x和y，其它后续指定
p <- ggplot(data_m, aes(x=variable,y=ID)) 
# 热图就是一堆方块根据其值赋予不同的颜色，所以这里使用fill=value, 用数值做填充色。
p <- p + geom_tile(aes(fill=value))   # p变量迭代的方式绘图
p
```
热图出来了，但有点不对劲，横轴重叠一起了。一个办法是调整图像的宽度，另一个是旋转横轴标记。
```
# theme: 是处理图美观的一个函数，可以调整横纵轴label的选择、图例的位置等。
# 这里选择X轴标签45度。
# hjust和vjust调整标签的相对位置，具体见 <https://stackoverflow.com/questions/7263849/what-do-hjust-and-vjust-do-when-making-a-plot-using-ggplot>。
# 简单说，hjust是水平的对齐方式，0为左，1为右，0.5居中，0-1之间可以取任意值。vjust是垂直对齐方式，0底对齐，1为顶对齐，0.5居中，0-1之间可以取任意值。
p <- p + theme(axis.text.x=element_text(angle=45,hjust=1, vjust=1))
p
```
设置想要的颜色。
```
# 连续的数字，指定最小数值代表的颜色和最大数值赋予的颜色
# 注意fill和color的区别，fill是填充，color只针对边缘
p <- p + scale_fill_gradient(low = "white", high = "red")
p
```
调整legend的位置。
```
# postion可以接受的值有 top, bottom, left, right, 和一个坐标 c(0.05,0.8) (左上角，坐标是相对于图的左下角计算的）
p <- p + theme(legend.position="top")
p
```
调整背景和背景格线以及X轴、Y轴的标题。(注意灰色的背景没了)
```
p <- p + xlab("samples") + theme_bw() + theme(panel.grid.major = element_blank()) + theme(legend.key=element_blank())
p
```
合并以上命令，就得到了下面这个看似复杂的绘图命令。
```
p <- ggplot(data_m, aes(x=variable,y=ID)) + xlab("samples") + theme_bw() + theme(panel.grid.major = element_blank()) + theme(legend.key=element_blank())  + theme(axis.text.x=element_text(angle=45,hjust=1, vjust=1)) + theme(legend.position="top") +  geom_tile(aes(fill=value)) + scale_fill_gradient(low = "white", high = "red")
```

## 保存图形
```
# 可以跟输出文件不同的后缀，以获得不同的输出格式
# colormode支持srgb （屏幕）和cmyk （打印，部分杂志需要，看上去有点褪色的感觉）格式
ggsave(p, filename="heatmap.pdf", width=10,
        height=15, units=c("cm"),colormodel="srgb")
```

