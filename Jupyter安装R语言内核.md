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
install.packages('devtools')
devtools::install_github('IRkernel/IRkernel')
IRkernel::installspec()
```
