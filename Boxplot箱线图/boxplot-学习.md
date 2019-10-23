# boxplot-学习

## 通过profile文件配置输入数据
``` rscript
profile="Name;2cell_1;2cell_2;2cell_3;4cell_1;4cell_2;4cell_3;zygote_1;zygote_2;zygote_3
A;4;6;7;3.2;5.2;5.6;2;4;3
B;6;8;9;5.2;7.2;7.6;4;6;5
C;8;10;11;7.2;9.2;9.6;6;8;7
D;10;12;13;9.2;11.2;11.6;8;10;9
E;12;14;15;11.2;13.2;13.6;10;12;11
F;14;16;17;13.2;15.2;15.6;12;14;13
G;15;17;18;14.2;16.2;16.6;13;15;14
H;16;18;19;15.2;17.2;17.6;14;16;15
I;17;19;20;16.2;18.2;18.6;15;17;16
J;18;20;21;17.2;19.2;19.6;16;18;17
L;19;21;22;18.2;20.2;20.6;17;19;18
M;20;22;23;19.2;21.2;21.6;18;20;19
N;21;23;24;20.2;22.2;22.6;19;21;20
O;22;24;25;21.2;23.2;23.6;20;22;21"
```
``` rscript
profile_text <- read.table(text=profile, header=T, row.names=1, quote="",sep=";", check.names=F)
```

## 载入所需的绘图包
``` rscript
library(ggplot2)
library(reshape2)
data_m <- melt(profile_text)
head(data_m)
```

## 箱线图 - 上色
``` rscript
p <- ggplot(data_m, aes(x=variable, y=value),color=variable) + 
  geom_boxplot(aes(fill=factor(variable))) + 
  theme(axis.text.x=element_text(angle=50,hjust=0.5, vjust=0.5)) +
  theme(legend.position="none")
p    ## 使用p作为中间变量，将绘图细节完全放入p变量；方便配合绘图设备导出图像（使用Rstudio时直接导出即可）；
```

## 小提琴图 - 从箱线图进一步修改
``` rscript
p <- ggplot(data_m, aes(x=variable, y=value),color=variable) + 
  geom_violin(aes(fill=factor(variable))) + 
  theme(axis.text.x=element_text(angle=50,hjust=0.5, vjust=0.5)) +
  theme(legend.position="none")
p
```
