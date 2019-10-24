# Barplot-学习

## 导入数据
有如下4个基因在5组样品中的表达值
```
data_ori <- "Grp_1;Grp_2;Grp_3;Grp_4;Grp_5
a;2.6;2.9;2.1;2.0;2.2
b;20.8;9.8;7.0;3.7;19.2
c;10.0;11.0;9.2;12.4;9.6
d;9;3.3;10.3;11.1;10"

data <- read.table(text=data_ori, header=T, row.names=1, sep=";", quote="")
```
## 整理数据格式，保留基因名字信息
```
library(ggplot2)
library(reshape2)
library(dplyr)
data_rownames <- rownames(data)
data_colnames <- colnames(data)
data$gene <- data_rownames
data_m <- melt(data, id.vars=c("gene"))
```
## 看下每个基因在不同组的表达情况
```
# 给定数据，和x轴、y轴所在列名字
# 直接使用geom_bar就可以绘制柱状图
# position: dodge: 柱子并排放置
p <- ggplot(data_m, aes(x=gene, y=value))
p + geom_bar(stat="identity", position="dodge", aes(fill=variable))
# 如果没有图形界面，运行下面的语句把图存在工作目录下的Rplots.pdf文件中
#dev.off()
```
## 柱子太多，也利用mean±SD的形式展现
首先计算平均值和标准差，使用group_by按gene分组，对每组做summarize
```
# 获取平均值和标准差
data_m_sd_mean <- data_m %>% group_by(gene) %>% dplyr::summarise(sd=sd(value), value=mean(value))
data_m_sd_mean <- as.data.frame(data_m_sd_mean)
```
## 使用geom_errorbar添加误差线
```
p <- ggplot(data_m_sd_mean, aes(x=gene, y=value)) + 
    geom_bar(stat="identity") +
    geom_errorbar(aes(ymin=value-sd, ymax=value+sd))
p
```
## 设置误差线的宽度和位置
```
p <- ggplot(data_m_sd_mean, aes(x=gene, y=value)) + 
    geom_bar(stat="identity", aes(fill=gene)) +
    geom_errorbar(aes(ymin=value-sd, ymax=value+sd), width=0.2, position=position_dodge(width=0.75))
p
```
