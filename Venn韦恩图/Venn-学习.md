# Venn-学习

## **本文并未提供相关脚本**

## Venn图-一步作图

```
a    ehbio1
b    ehbio1
c    ehbio1
d    ehbio1
e    ehbio1
f    ehbio1
g    ehbio1
h    ehbio2
i    ehbio2
j    ehbio2
k    ehbio2
e    ehbio2
f    ehbio2
g    ehbio2
a    ehbio3
b    ehbio3
h    ehbio3
j    ehbio3
i    ehbio3
f    ehbio3
g    ehbio3
a    ehbio4
b    ehbio4
h    ehbio4
d    ehbio5
e    ehbio5
y    ehbio5
x    ehbio5
```
选取所有的5个集合，绘制韦恩图
```
# -f: 指定输入文件的名字，格式如上
# -a: 指定第一个集合的名字 (-f指定的文件中第二列的某个字符串)
# -b: 指定第二个集合的名字 (-f指定的文件中第二列的某个字符串)
# -c, -d, -g: 指定第三、四、五个集合的名字
sp_vennDiagram.sh -f venn.txt -a ehbio1 -b ehbio2 -c ehbio3 -d ehbio4 -g ehbio5
```
选取其中4个集合，绘制韦恩图
```
# -f: 指定输入文件的名字，格式如上
# -a: 指定第一个集合的名字 (-f指定的文件中第二列的某个字符串)
# -b: 指定第二个集合的名字 (-f指定的文件中第二列的某个字符串)
# -c, -d: 指定第三、四个集合的名字
sp_vennDiagram.sh -f venn.txt -a ehbio1 -b ehbio2 -c ehbio3 -d ehbio5
```
选取其中3个集合，绘制韦恩图
```
# -f: 指定输入文件的名字，格式如上
# -a: 指定第一个集合的名字 (-f指定的文件中第二列的某个字符串)
# -b: 指定第二个集合的名字 (-f指定的文件中第二列的某个字符串)
# -c: 指定第三个集合的名字
sp_vennDiagram.sh -f venn.txt -a ehbio1 -b ehbio2 -c ehbio3
```
也可以提供数字绘制Venn图
```
# -f: 指定输出图片的前缀
# -F TRUE: 指定根据给定的数字绘图
# -n: 提供每个集合的数据，具体解释见下
# -l: 指定集合的名字，按下面的解释指定
sp_vennDiagram.sh -f venn -F TRUE -n "120, 110, 50"  -l "'EHBIO','SXBD'"
```

## UpSetView展示

对于集合比较多的时候，包括上面提到的5个集合的交并集情况，如果只是为了展示个炫图，还可以，但如果想解释结果，就会比较头疼，难判断区域的归属。

因此对于这种多集合情况，推荐使用UpSetView展示，看效果如下。

测试数据，存储为upsetview.txt （第一行为集合的名，每个集合一列；每一行为一个ID，如果对应ID出现在这个集合则标记1，否则标记0）：

```
pattern    ehbio1    ehbio2    ehbio3    ehbio4    ehbio5
a    1    0    1    1    0
b    1    0    1    1    0
c    1    0    0    0    0
d    1    0    0    0    1
e    1    1    0    0    1
f    1    1    1    0    0
g    1    1    1    0    0
h    0    1    1    1    0
i    0    1    1    0    0
j    0    1    1    0    0
k    0    1    0    0    0
x    0    0    0    0    1
y    0    0    0    0    1
```
```
# 只需要指定符合格式的输入文件就可以
# 如果提示包确实，再指定 -i TRUE
sp_upsetView.sh -f upsetview.txt
```
UpSetR: http://www.caleydo.org/tools/upset/ 采用连线的方式展示不同的组合之间共有的和特有的项目，对于特别多的组合尤其适用。

单个点表示特有，连起来的点表示共有，相当于venn图中重叠的部分。

垂直的柱子代表的是Venn图中的数字，看连接的点判断归属。

水平的柱子代表对应样品中Item的总数。
