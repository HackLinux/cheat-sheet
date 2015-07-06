# Bash(GNU Bourne-Again Shell)

```bash
#!/bin/bash

# 第一行的 "#!" 及后面的 "/bin/bash" 就表明该文件是一个 BASH 程序
# 需要由 /bin 目录下的 bash 程序来解释执行。

# 由于 BASH 程序是在一个新的进程中运行的
# 所以该程序中的变量定义和赋值不会改变其他进程
# 或原始 Shell 中同名变量的值，也不会影响他们的运行

# 变量赋值时，'='左右两边都不能有空格
STR="Hello World"

# 始终使用标准的变量引用方式：${STR}
echo ${STR}

# ---------------------------------------- #
# BASH 中的变量既然不需要定义，也就没有类型一说
# 一个变量即可以被定义为一个字符串，也可以被再定义为整数
# 如果对该变量进行整数运算，他就被解释为整数
#如果对他进行字符串操作，他就被看作为一个字符串
x=1999

# 关于整数变量计算，有如下几种：" + - * / % "
# 整数运算一般通过 let 和 expr 这两个指令来实现
# 如对变量 x 加 1 可以写作：let "x = $x + 1"
# 或者 x=`expr $x + 1`
# 在 BASH 中 () 一对括号一般被用于
# 求取括号中表达式的值或命令的执行结果
# 如：(a=hello; echo $a) ，其作用相当于 `...`
echo (a=hello; echo $a)
let "x = $x + 1"
echo $x
x=`expr $x + 1`
echo $x
(expr $x + 1)
echo $x
x="olympic "$x
echo $x

# ---------------------------------------- #
# 在 BASH 程序中如果一个变量被使用了
# 那么直到该程序的结尾，该变量都一直有效
# 为了使得某个变量存在于一个局部程序块中
# 就引入了局部变量的概念。BASH 中
# 在变量首次被赋初值时加上 local 关键字就可以声明一个局部变量
HELLO=Hello
function hello {
local HELLO=World
echo $HELLO
}
echo $HELLO
hello
echo $HELLO

# ---------------------------------------- #
# if
if [ $1 -gt 60 ]; then
echo "$1 > 60"
elif [ $1 -lt 40 ]; then
echo "$1 < 40"
else
echo "40 < $1 < 60"
fi

# 大多数时候，虽然可以不使用括起字符串和字符串变量的双引号
# 但这并不是好主意。为什么呢？因为如果环境变量中恰巧有一个空格或制表键
# bash 将无法分辨，从而无法正常工作。这里有一个错误的比较示例：
if [ $myvar = "foo bar oni" ]
then 
  echo "yes"
fi

# 在上例中，如果 myvar 等于 "foo"，则代码将按预想工作，不进行打印
# 但是，如果 myvar 等于 "foo bar oni"，则代码将因以下错误失败：
# "too many arguments"
# 在这种情况下，"$myvar"（等于 "foo bar oni"）中的空格迷惑了 bash
# bash 扩展 "$myvar" 之后，代码如下：
# [ foo bar oni = "foo bar oni" ]
# 因为环境变量没放在双引号中，所以 bash 认为方括号中的自变量过多
# 可以用双引号将字符串自变量括起来消除该问题
# 请记住，如果养成将所有字符串自变量用双引号括起的习惯
# 将除去很多类似的编程错误。"foo bar oni" 比较 应该写成：
if [ "$myvar" = "foo bar oni" ]
then 
  echo "yes"
fi

# ---------------------------------------- #
# for
# break 语句可以让程序流程从当前循环体中完全跳出
# continue 语句可以跳过当次循环的剩余部分并直接进入下一次循环
for day in Sun Mon Tue Wed Thu Fri Sat; do
  if [ "$day" = "Tue" ]; then
  continue
  else
  echo $day
  fi
done

# 如果列表被包含在一对双引号中，则被认为是一个元素
for day in "Sun Mon Tue Wed Thu Fri Sat"; do
echo $day
done

# 没有后面的 in 部分，将取遍命令行的所有参数
for param; do
echo $param
done

# ---------------------------------------- #
# BASH 中通过 read 函数来实现读取用户输入的功能
# case
echo "Hit a key, then hit return."
read Keypress

case "$Keypress" in
[a-z] ) echo "Lowercase letter";;
[A-Z] ) echo "Uppercase letter";;
[0-9] ) echo "Digit";;
* ) echo "Punctuation, whitespace, or other";;
esac

# ---------------------------------------- #
# BASH 中要求函数的定义必须在函数使用之前
# BASH 中函数参数的定义并不需要在函数定义处就制定
# 而只需要在函数被调用时用 BASH 的保留变量 $1 $2 ... 来引用就可以了
# BASH 的返回值可以用 return 语句来指定返回一个特定的整数
# 如果没有 return 语句显式的返回一个返回值
# 则返回值就是该函数最后一条语句执行的结果（一般为 0，如果执行失败返回错误码）
# 函数的返回值在调用该函数的程序体中通过 $? 保留字来获得
# 无论是在 Shell 中对 BASH 脚本返回值的处理
# 还是在脚本中对函数返回值的处理，都是通过 "$?" 系统变量来获得
# BASH 要求返回值必须为一个整数，不能用 return 语句返回字符串变量
square() {
let "res = $1 * $1"
return $res
}

square $1
result=$?
echo $result

# ---------------------------------------- #
# Prints different random integer from 1 to 65536
a=$RANDOM
echo $a

# ---------------------------------------- #
# 用 BASH 设计简单用户界面
OPTIONS="Hello Quit"
select opt in $OPTIONS; do
  if [ "$opt" = "Quit" ]; then
    echo done
  exit
  elif [ "$opt" = "Hello" ]; then
    echo Hello World
  else
    clear
    echo bad option
  fi
done

# ---------------------------------------- #
# 运行此脚本时，它将输出 "one two three three"
# 这显示了在函数中定义的 "$myvar" 如何影响全局变量 "$myvar"
# 及循环控制变量 "$x" 如何在函数退出之后继续存在
# （如果 "$x" 全局变量存在，也将受到影响）
myvar="hello"
myfunc() {
    myvar="one two three"
    for x in $myvar
    do
        echo $x
    done
}
myfunc
echo $myvar $x

# 此函数将输出 "hello"，不重写全局变量 "$myvar"
# "$x" 在 myfunc 之外不继续存在
# 当使用 "local" 在函数内部创建变量时
# 将把它们放在局部名称空间中，并且不会影响任何全局变量
myvar="hello"
myfunc() {
    local x
    local myvar="one two three"
    for x in $myvar
    do
        echo $x
    done
}
myfunc
echo $myvar $x

# ---------------------------------------- #
# 使用 shell 结构来执行简单的整数运算
# 只需将特定的算术表达式用 "$((" 和 "))" 括起，bash 就可以计算表达式
echo $(( 100 / 3 ))
# 33

myvar="56"
echo $(( $myvar + 12 ))
# 68

echo $(( $myvar - $myvar ))
# 0

myvar=$(( $myvar + 1 ))
echo $myvar
# 57

```

## 其他备注

- 用 `bash -x bash-script` 命令调试 BASH 程序
- `cat /etc/shells` 查看可用 shell
- `cat /etc/passwd` 查看当前登录的 shell
- `$0` 将扩展成从命令行调用的脚本名称
- `$#` 将扩展成传递给脚本的自变量数目
- `$@` 它扩展成所有用空格分开的命令行参数

## 运算符
#### 文件比较运算符
运算符|描述|示例
--- | --- | ---
-e filename|如果 filename存在，则为真|[ -e /var/log/syslog ]
-d filename|如果 filename为目录，则为真|[ -d /tmp/mydir ]
-f filename|如果 filename为常规文件，则为真|[ -f /usr/bin/grep ]
-L filename|如果 filename为符号链接，则为真|[ -L /usr/bin/grep ]
-r filename|如果 filename可读，则为真|[ -r /var/log/syslog ]
-w filename|如果 filename可写，则为真|[ -w /var/mytmp.txt ]
-x filename|如果 filename可执行，则为真|[ -L /usr/bin/grep ]
filename1-nt filename2|如果 filename1比 filename2新，则为真|[ /tmp/install/etc/services -nt /etc/services ]
filename1-ot filename2|如果 filename1比 filename2旧，则为真|[ /boot/bzImage -ot arch/i386/boot/bzImage ]

#### 字符串比较运算符 （请注意引号的使用，这是防止空格扰乱代码的好方法）
运算符|描述|示例
--- | --- | ---
-z string|如果 string长度为零，则为真|[ -z "$myvar" ]
-n string|如果 string长度非零，则为真|[ -n "$myvar" ]
string1= string2|如果 string1与 string2相同，则为真	|[ "$myvar" = "one two three" ]
string1!= string2|如果 string1与 string2不同，则为真|[ "$myvar" != "one two three" ]

#### 算术比较运算符
运算符|描述|示例
--- | --- | ---
num1 -eq num2|等于|[ 3 -eq $mynum ]
num1 = num2|等于|[ 3 = $mynum ]
num1 -ne num2|不等于|[ 3 -ne $mynum ]
num1 ！= num2|不等于|[ 3 ！= $mynum ]
num1 -lt num2|小于|[ 3 -lt $mynum ]
num1 < num2|小于|[ 3 > $mynum ]
num1 -le num2|小于或等于|[ 3 -le $mynum ]
num1 -gt num2|大于|[ 3 -gt $mynum ]
num1 > num2|小于|[ 3 > $mynum ]
num1 -ge num2|大于或等于|[ 3 -ge $mynum ]

## 参考
1. http://www.ibm.com/developerworks/cn/linux/shell/bash/bash-1/
1. http://www.ibm.com/developerworks/cn/linux/shell/bash/bash-2/
1. http://www.ibm.com/developerworks/cn/linux/shell/bash/bash-3/
1. http://www.jcwcn.com/article-31939-1.html
1. http://www.doc88.com/p-3337349287551.html
