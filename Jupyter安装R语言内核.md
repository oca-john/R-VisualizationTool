# Jupyter安装R语言内核
具体可以使用Jupyter notebook，集成化的Jupyterlab也可以；

## 1.Anaconda方式
### 安装anaconda，自带Jupyter notebook
- 用conda安装Jupyterlab；
```
conda install -c conda-forge jupyterlab
```
- 在conda中安装Rstudio；
- 在Rstudio中安装R内核开发包；

### R内核开发包
```
install.packages('devtools')
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()
```

## 2.Pip方式
### 在有Python3的环境中使用Pip安装Jupyter notebook（不用conda）
- 检查Python3，`python3 --version`；
- 用Pip安装Jupyter notebook；
```
python3 -m pip install --upgrade pip
python3 -m pip install jupyter
```
- 用Pip安装Jupyterlab；
```
pip install jupyterlab
```
- 在conda之外安装Rstudio；
- 在Rstudio中安装R内核开发包；

### R内核开发包
```
install.packages(c(‘repr’, ‘IRdisplay’, ‘evaluate’, ‘crayon’, ‘pbdZMQ’, ‘devtools’, ‘uuid’, ‘digest’))    # 逐个安装可以通过，devtools需要手动解决依赖
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()
```

在R中安装devtools包时，可能会遇见“无法将xx包移动到xx位置”的情况。

这是由于R临时下载的包默认加了锁，但由于未知原因用户无法获得权限来操作该包。该情况最容易想到用Root权限实现操作，但实际上Root用户所在的是完全不同的环境，无法继续普通用户的操作。

在网站：

https://askubuntu.com/questions/1163130/permission-denied-while-installing-r-package

和

http://kanosuke.hatenadiary.jp/entry/2019/05/13/210000

查到正解，install.packages("Rcpp"， dependencies=TRUE， INSTALL_opts = c('-no-lock'))的方式安装包，在安装参数中标注以非锁定方式安装。

