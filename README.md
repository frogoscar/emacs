# emacs
My Emacs configuration file and three modules
我的Emacs配置文件和三个模块

## Containing four files:
## 包含四个文件：

  - .emacs
  - modules/php-mode.el
  - modules/psvn.el
  - modules/saved-places
 
## Usage
## 用法
 
  - Install Emacs first 首先需要安装Emacs
  - copy .emacs to ~ (your home folder) 把 .emacs 文件拷贝到你的家目录（~）
  - copy the folder module to ~/.emacs.d/ 把 modules 文件夹拷贝到你的家目录下面的.emacs.d 这个目录（~/.emacs.d/）


## Frequently used shortcuts
## 常用的快捷键组合


M-s  ： 新建一个buffer（缓冲区）

C-x O ： 注意是大写的O，不是零，所以需要按住shift键再按o键。用于在缓冲区之间切换

C-g ： 取消当前操作

C-x u ：  回到上一步，相当于Undo

C-x 3 ： 把缓冲区（buffer）分为左右两个，新的一个缓冲区是复制当前的缓冲区 （可以执行多次，来分割出很多小窗口）

C-x 2 ： 把缓冲区（buffer）分为上下两个，新的一个缓冲区是复制当前的缓冲区 （可以执行多次，来分割出很多小窗口）

M-w ： 选中文字的情况是复制文字，而如果没有选中文字则是复制当前的一行

C-w ： 选中文字的情况是剪切文字，而如果没有选中文字则是剪切当前的一行

M-x ： 调出命令输入，可以在后面接命令，比如man，svn-status，等

C-y ： 黏贴

C-x C-s ： 保存文本

C-x C-f ： 打开文件，如果文件不存在，则新建文件

C-x C-v ： 打开一个文件，取代当前缓冲区

C-x k ： 关闭当前缓冲区（buffer）

C-s ： 向前搜索

C-r ： 向后搜索

C-x h ： 全选

C-v ： 向下翻页

M-v ： 向上翻页

C-f ： 前进一个字符

C-b ： 后退一个字符

M-f ： 前进一个单词

M-b ： 后退一个单词

C-@ ： 标记开始区域

C-a ： 移到行首

C-e ： 移到行尾

M-a ： 移到句首

M-e ： 移到句尾

M-< ： 缓冲区头部

M-> ： 缓冲区尾部

M-g M-g，再输入数字 ： 跳转到文本的第几行

C-x 0 ： 关闭当前缓冲区

C-x C-c ： 退出Emacs

## Etags用法：

rm -f TAGS
find . -name "*.cc" -print -or -name "*.h" -print -or -name "*.java" -print | xargs etags -a

M-. 跳至定义处
M-* 跳回
C-u M-. 查找下一个tags
