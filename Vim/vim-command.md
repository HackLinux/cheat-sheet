# Vim

```
├── .vim
│   ├── colors   配色方案
│   ├── plugin   插件
│   ├── doc      说明文档
│   ├── syntax   语法高亮
│   ├── after    修正脚本
   └── autoload 自动加载
```

## 操作相关

### 光标移动

| 操作             | 说明                                     | 备注                                |
------------------|------------------------------------------|-------------------------------------
| `+`              | 光标移动到下一行非空格处                 |  |
| `-`              | 光标移动到上一行非空格处                 |  |
| `0`              | 光标移动到这一行的最前面字符处           | 或功能键 **Home** |
| `$`              | 光标移动到这一行的最后面字符处           | 或功能键 **End**，`$`在正则里面表示是结尾|
| `H`              | 光标移动到屏幕最上方一行的第一个字符     | `H`是 *header*的缩写|
| `M`              | 光标移动到屏幕中夬那一行的第一个字符     | `M`是 *middle*的缩写|
| `L`	           | 光标移动到屏幕最下方一行的第一个字符     | `L`是 *last*的缩写|
| `*`	           | 光标移动到下一个, 光标当前所在的单词     | `#`是移动到下一个|


### 查找相关

`/aa\|bb`

| vim    |  意义|
---------|---------------------
| *	     |  0个或多个(匹配优先)|
| \+     |  1个或多个(匹配优先)|
| \?     |  0个或1个(匹配优先)|
| \{n,m} |  n个到m个(匹配优先)|
| \{n,}  |  最少n个(匹配优先)|
| \{,m}  |  最多m个(匹配优先)|
| \{n}   |  恰好n个
| \{-n,m}| 	n个到m个(忽略优先)|
| \{-}   |  0个或多个(忽略优先)|
| \{-1,} |  1个或多个(忽略优先)|
| \{-,1} |  0个或1个(忽略优先)|

```
\        取消后面所跟字符的特殊含义。比如 \[vim\] 匹配字符串“[vim]”
[]       匹配其中之一。比如 [vim] 匹配字母“v”、“i”或者“m”，[a-zA-Z] 匹配任意字母
[^]      匹配非其中之一。比如 [^vim] 匹配除字母“v”、“i”和“m”之外的所有字符
.        匹配任意字符
*        匹配前一字符大于等于零遍。比如 vi*m 匹配“vm”、“vim”、“viim”……
\+       匹配前一字符大于等于一遍。比如 vi\+m 匹配“vim”、“viim”、“viiim”……
\?       匹配前一字符零遍或者一遍。比如 vi\?m 匹配“vm”或者“vim”
^        匹配行首。例如 /^hello 查找出现在行首的单词 hello
$        匹配行末。例如 /hello$ 查找出现在行末的单词 hello
\(\)     括住某段正规表达式
\数字    重复匹配前面某段括住的表达式。例如 \(hello\).*\1 匹配一个开始和末尾都是“hello”，中间是任意字符串的字符串

对于替换字符串，可以用“&”代表整个搜索字符串，或者用“\数字”代表搜索字符串中的某段括住的表达式。

举一个复杂的例子，把文中的所有字符串“abc……xyz”替换为“xyz……abc”可以有下列写法：
:%s/abc\(.*\)xyz/xyz\1abc/g
:%s/\(abc\)\(.*\)\(xyz\)/\3\2\1/g
```


### 复制黏贴

| 操作      | 说明                                     |
 -----------|------------------------------------------|
|`d1G`/`y1G`|删除/复制光标所在行到第一行的所有数据（**是数字`1`**）|
|`dG`/`yG`  |删除/复制光标所在行到最后一行的所有数据|
|`d$`/`y$`  |删除/复制光标所在处到该行的最后字符的所有数据|
|`d0`/`y0`  |删除/复制光标所在处到该行的开始字符的所有数据（**是数字`0`**）|
|`J`     	|将光标所在行不下一行的数据结合成同一行|

### 字符串替换

- 在第2-7行之间，将ddd替换成fff

  `:2,7s/ddd/fff/g`

- 在第一行到最后一行之间替换

  `:1,$s/string1/string2/g`

- 替换前显示提示字符给用户确认 (confirm) 是否需要替换！

 `:1,$s/string1/string2/gc`

- add string2 to end of every line

 `:1,$s/$/string2/gc`

### 其他

- `F9` taglist
- `F10` NerdTree
- `F11` fullscream
- `F12` Rgrep
- `:Pydoc`
- `:find`
- `q` quit taglist

zz: 将当前行置于屏幕中间（不是转载…）
zt: 将当前行置于屏幕顶端（不是猪头~）
zb：底端啦~

- 另存为

  `:w [filename]`

- 在编辑的数据中，读入另一个档案的数据。亦即将 *filename* 这个档案内容加到光标所在行后面

  `:r [filename]`

- 暂时离开 vi 到指令列模式下执行 command 的显示结果！

  `:! command`

- 退出所有窗口

  `:qall`

### quickfix

- `:copen (:cope)` 打开quickfix窗口，列出所有结果，可以直接用鼠标点击打开
- `:cnext (:cn)` 当前页下一个结果
- `:cprevious (:cp)` 当前页上一个结果
- `:clist (:cl)` 打开quickfix窗口，列出所有结果，不能直接用鼠标点击打开，只能看
- `:ccl[ose]` 关闭 quickfix 窗口。

### ctags & taglist

- ctags & taglist
for more info please see `vimrc` file

```
sudo apt-get install ctags
cd /path/to/project/root/dir/
ctags -R      //生成tags文件
```

###
grep -r "HttpServer" ./**/*.md
> VIM中arg和argdo的使用介绍
> 在工作中常常需要对成百上千个纯文本进行批量替换操作，经过多次试验，我认为使用VIM是最好的办法。
> 我们需要用到的是VIM的args和 argdo 两个命令。
> args的用处是把需要进行批量操作的文件标记出来。例如：
> args d:\a\*.txt
> args d:\a\**\*.txt
>
> 以上示例中的第一个是把D盘a目录下的所有纯文本文件作上标记，第二个则包括子目录。
> 在VIM中可以使用pwd命令查看VIM的当前目录，可以使用cd命令改变当前目录的位置。例如：
> cd d:\a\
> args会找到指定目录下的所有指定类型的文件并以编辑第一个。现在可以对所有的文件进行同一个替换操作。
> :argdo %s/\<x_cnt\>/x_counter/ge | update
>
> ":argdo"命令以另一个命令为参数。该命令将对所有待编辑的文件都执行一次。
> "%s"替换操作将施于所有行上。它通过"\<x_cnt\>"查找"x_cnt"。其中"\<"和"\>"使得只有完整的单词会被匹配，这样"px_cnt"和"x_cnt2"中的x_cnt才可以免遭毒手。
> 替换操作的标志"g"使得每行中的全部"x_cnt"都被替换。标志"e"则用于避免某些文件中一个"x_cnt"都找不到时的错误消息。否则的话":argdo"命令遇到这些错误就会终止整个操作。
> "|"用来分隔两个命令。后面的"update"命令会在文件有改变时进行保存。如果没有一个"x_cnt"被替换为"x_counter"那就不进行任何操作。
>
> 在实际操作中还有一点小技巧，那就是如何避免在操作中频繁出现“请按Enter或其他命令继续”以及出现“更多”的提示而需要按空格键继续，如果要操作的文件数目很多，频繁地按回车或空格键会把人整疯的。
> 在vimrc文件中作如下设定：
> set nomore
> 打开more选项，列表消息会在全屏填满时暂停，通过nomore选项关闭就不会有暂停，列表消息会继续进行直到结束为止。

### `vimdiff filename1 filename2`

### args & argdo

<table>
<thead>
<tr>
<th align="center">元字符 </th>
<th align="left"> 说明</th>
</tr>
</thead>
<tbody>
<tr>
<td align="center">*     </td>
<td align="left"> 匹配0-任意个</td>
</tr>
<tr>
<td align="center">\+    </td>
<td align="left"> 匹配1-任意个</td>
</tr>
<tr>
<td align="center">\?    </td>
<td align="left"> 匹配0-1个</td>
</tr>
<tr>
<td align="center">\{n,m}</td>
<td align="left"> 匹配n-m个</td>
</tr>
<tr>
<td align="center">\{n}  </td>
<td align="left"> 匹配n个</td>
</tr>
<tr>
<td align="center">\{n,} </td>
<td align="left"> 匹配n-任意个</td>
</tr>
<tr>
<td align="center">\{,m} </td>
<td align="left"> 匹配0-m个</td>
</tr>
</tbody>
</table>

<table>
<thead>
<tr>
<th align="center"> 元字符 </th>
<th align="left"> 说明</th>
</tr>
</thead>
<tbody>
<tr>
<td align="center"> .      </td>
<td align="left"> 匹配任意字符</td>
</tr>
<tr>
<td align="center"> [abc]  </td>
<td align="left"> 匹配方括号中的任意一个字符，可用<code>-</code>表示字符范围。如[a-z0-9]匹配小写字母和数字</td>
</tr>
<tr>
<td align="center"> [^abc] </td>
<td align="left"> 匹配除方括号中字符之外的任意字符</td>
</tr>
<tr>
<td align="center"> \d     </td>
<td align="left"> 匹配阿拉伯数字，等同于[0-9]</td>
</tr>
<tr>
<td align="center"> \D     </td>
<td align="left"> 匹配阿拉伯数字之外的任意字符，等同于[^0-9]</td>
</tr>
<tr>
<td align="center"> \x     </td>
<td align="left"> 匹配十六进制数字，等同于[0-9A-Fa-f]</td>
</tr>
<tr>
<td align="center"> \X     </td>
<td align="left"> 匹配十六进制数字之外的任意字符，等同于[^0-9A-Fa-f]</td>
</tr>
<tr>
<td align="center"> \l     </td>
<td align="left"> 匹配[a-z]</td>
</tr>
<tr>
<td align="center"> \L     </td>
<td align="left"> 匹配[^a-z]</td>
</tr>
<tr>
<td align="center"> \u     </td>
<td align="left"> 匹配[A-Z]</td>
</tr>
<tr>
<td align="center"> \U     </td>
<td align="left"> 匹配[^A-Z]</td>
</tr>
<tr>
<td align="center"> \w     </td>
<td align="left"> 匹配单词字母，等同于[0-9A-Za-z_]</td>
</tr>
<tr>
<td align="center"> \W     </td>
<td align="left"> 匹配单词字母之外的任意字符，等同于[^0-9A-Za-z_]</td>
</tr>
<tr>
<td align="center"> \t     </td>
<td align="left"> 匹配<code>&lt;TAB&gt;</code>字符</td>
</tr>
<tr>
<td align="center"> \s     </td>
<td align="left"> 匹配空白字符，等同于[\t]</td>
</tr>
<tr>
<td align="center"> \S     </td>
<td align="left"> 匹配非空白字符，等同于[^\t]</td>
</tr>
</tbody>
</table>

```
:args **/*.*
:argdo %s/oldword/newword/egc | update
```

- `:0,s/^/#/gc`
在行首加一个#号

- `:6,10s/^/#/gc`
在6~10行的行首加一个#号

- `:%s/^ *//g`
删除行首的空格

- `:%s/ *$//g` or `:%s/\s\+$//g`
删除行尾的空格

- `%s/^\n//g`
删除空行：

