[toc]


# Python

``` python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
```

统一函数和类命名：类名用 **驼峰命名**， 函数和方法名，用 `小写_和_下划线`。总是用 `self` 作为方法的第一个参数。

## slice

### for string

``` python
>>> word = 'Help' + 'A'
>>> word
'HelpA'
```
方便记忆的方法
```
 +---+---+---+---+---+
 | H | e | l | p | A |
 +---+---+---+---+---+
 0   1   2   3   4   5
-5  -4  -3  -2  -1   0
```
索引切片可以有默认值，切片时，忽略第一个索引的话，默认为 0，忽略第二个索引，默认为字符串的长度:
``` python
>>> word[:2]    # The first two characters
'He'
>>> word[2:]    # Everything except the first two characters
'lpA'
```
切片操作有个有用的不变性：`s[:i] + s[i:]` 等于 `s`:
``` python
>>> word[:2] + word[2:]
'HelpA'
>>> word[:3] + word[3:]
'HelpA'
```
索引也可以是负数，这将导致从右边开始计算。例如:
``` python
>>> word[-1]     # The last character
'A'
>>> word[-2]     # The last-but-one character
'p'
>>> word[-2:]    # The last two characters
'pA'
>>> word[:-2]    # Everything except the last two characters
'Hel'
```

### for list

就像字符串索引，列表从 0 开始检索。列表可以被切片和连接:
``` python
>>> a[0]
'spam'
>>> a[3]
1234
>>> a[-2]
100
>>> a[1:-1]
['eggs', 100]
>>> a[:2] + ['bacon', 2*2]
['spam', 'eggs', 'bacon', 4]
>>> 3*a[:3] + ['Boo!']
['spam', 'eggs', 100, 'spam', 'eggs', 100, 'spam', 'eggs', 100, 'Boo!']
```
所有的切片操作都会返回新的列表，包含求得的元素。这意味着以下的切片操作返回列表 a 的一个浅拷贝的副本:
``` python
>>> a[:]
['spam', 'eggs', 100, 1234]
```
不像 **不可变的** 字符串，列表允许修改元素:
``` python
>>> a
['spam', 'eggs', 100, 1234]
>>> a[2] = a[2] + 23
>>> a
['spam', 'eggs', 123, 1234]
```
也可以对切片赋值，此操作可以改变列表的尺寸，或清空它:
``` python
>>> # Replace some items:
... a[0:2] = [1, 12]
>>> a
[1, 12, 123, 1234]
>>> # Remove some:
... a[0:2] = []
>>> a
[123, 1234]
>>> # Insert some:
... a[1:1] = ['bletch', 'xyzzy']
>>> a
[123, 'bletch', 'xyzzy', 1234]
>>> # Insert (a copy of) itself at the beginning
>>> a[:0] = a
>>> a
[123, 'bletch', 'xyzzy', 1234, 123, 'bletch', 'xyzzy', 1234]
>>> # Clear the list: replace all items with an empty list
>>> a[:] = []
>>> a
[]
```
允许嵌套列表（创建一个包含其它列表的列表），例如:
``` python
>>> q = [2, 3]
>>> p = [1, q, 4]
>>>> p[1].append('xtra')
>>> p
[1, [2, 3, 'xtra'], 4]
>>> q
[2, 3, 'xtra']
```
> NOTE: `p[1]` 和 `q` 实际上指向同一个对象！我们会在后面的 *object semantics* 中继续讨论。

## for loop

### 使用切片修改你迭代的序列

如果你想要修改你迭代的序列，使用切片可以很方便的做到这一点:
``` python
>>> # Measure some strings:
... a = ['cat', 'window', 'defenestrate']
>>> for x in a:
...     print(x, len(x))
...
cat 3
window 6
defenestrate 12
>>> for x in a[:]: # make a slice copy of the entire list
...    if len(x) > 6: a.insert(0, x)
...
>>> a
['defenestrate', 'cat', 'window', 'defenestrate']
```

### enumerate()

在序列中循环时，索引位置和对应值可以使用 `enumerate()` 函数同时得到:
``` python
>>> for i, v in enumerate(['tic', 'tac', 'toe']):
...     print(i, v)
...
0 tic
1 tac
2 toe
```

### reversed()

需要逆向循环序列的话，先正向定位序列，然后调用 reversed() 函数:
``` python
>>> for i in reversed(range(1, 10, 2)):
...     print(i)
...
9
7
5
3
1
```

### sorted()

要按排序后的顺序循环序列的话，使用 sorted() 函数，它不改动原序列，而是生成一个新的已排序的序列:
``` python
>>> basket = ['apple', 'orange', 'apple', 'pear', 'orange', 'banana']
>>> for f in sorted(set(basket)):
...     print(f)
...
apple
banana
orange
pear
```

## def function()

### lambda

出于实际需要，有几种通常在函数式编程语言例如 Lisp 中出现的功能加入到了 Python。通过 lambda 关键字，可以创建短小的匿名函数。这里有一个函数返回它的两个参数的和： lambda a, b: a+b。 Lambda 形式可以用于任何需要的函数对象。出于语法限制，它们只能有一个单独的表达式。语义上讲，它们只是普通函数定义中的一个语法技巧。类似于嵌套函数定义，lambda 形式可以从外部作用域引用变量:
``` python
>>> def make_incrementor(n):
...     return lambda x: x + n
...
>>> f = make_incrementor(42)
>>> f(0)
42
>>> f(1)
43
```

### docstrings

``` python
>>> def my_function():
...     """Do nothing, but document it.
...
...     No, really, it doesn't do anything.
...     """
...     pass
...
>>> print(my_function.__doc__)
Do nothing, but document it.

    No, really, it doesn't do anything.
```

### TODO：函数定义

函数，函数局部变量引用，首先在 **局部符号表** 中查找，然后是 **包含函数的局部符号表**，然后是 **全局符号表**，最后是 **内置名字表**。因此，全局变量不能在函数中直接赋值（除非用 `global` 语句命名），尽管他们可以被引用。
``` python
>>> def fib(n):    # write Fibonacci series up to n
...     """Print a Fibonacci series up to n."""
...     a, b = 0, 1
...     while a < n:
...         print(a, end=' ')
...         a, b = b, a+b
...     print()
...
>>> # Now call the function we just defined:
... fib(2000)
0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597
```
一个函数定义会在当前符号表内引入函数名。函数名指代的值（即函数体）有一个被 Python 解释器认定为 用户自定义函数 的类型。 这个值可以赋予其他的名字（即变量名），然后它也可以被当做函数使用。这可以作为通用的重命名机制:
``` python
>>> fib
<function fib at 10042ed0>
>>> f = fib
>>> f(100)
0 1 1 2 3 5 8 13 21 34 55 89
```

## list

### basic method

``` python
>>> a = [66.25, 333, 333, 1, 1234.5]
>>> print(a.count(333), a.count(66.25), a.count('x'))
2 1 0
>>> a.insert(2, -1)
>>> a.append(333)
>>> a
[66.25, 333, -1, 333, 1, 1234.5, 333]
>>> a.index(333)
1
>>> a.remove(333)
>>> a
[66.25, -1, 333, 1, 1234.5, 333]
>>> a.reverse()
>>> a
[333, 1234.5, 1, 333, -1, 66.25]
>>> a.sort()
>>> a
[-1, 1, 66.25, 333, 333, 1234.5]
```

### 把链表当作栈使用

用 `append()` 方法可以把一个元素添加到堆栈顶。用不指定索引的 `pop()` 方法可以把一个元素从堆栈顶释放出来。例如:
``` python
>>> stack = [3, 4, 5]
>>> stack.append(6)
>>> stack.append(7)
>>> stack
[3, 4, 5, 6, 7]
>>> stack.pop()
7
>>> stack
[3, 4, 5, 6]
>>> stack.pop()
6
>>> stack.pop()
5
>>> stack
[3, 4]
```

### 使用 `collections.deque` 实现队列

它为在首尾两端快速插入和删除而设计:

``` python
>>> from collections import deque
>>> queue = deque(["Eric", "John", "Michael"])
>>> queue.append("Terry")           # Terry arrives
>>> queue.append("Graham")          # Graham arrives
>>> queue.popleft()                 # The first to arrive now leaves
'Eric'
>>> queue.popleft()                 # The second to arrive now leaves
'John'
>>> queue                           # Remaining queue in order of arrival
deque(['Michael', 'Terry', 'Graham'])
```

### 列表推导式

列表推导式为从序列中创建列表提供了一个简单的方法。普通的应用程式通过将一些操作应用于序列的每个成员并通过返回的元素创建列表，或者通过满足特定条件的元素创建子序列。

例如, 假设我们创建一个 `squares` 列表, 可以像下面方式:
``` python
>>> squares = []
>>> for x in range(10):
...     squares.append(x**2)
...
>>> squares
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```
我们同样能够达到目的采用下面的方式:
``` python
squares = [x**2 for x in range(10)]
```
这也相当于 `squares = map(lambda x: x**2, range(10))`，但是上面的方式显得简洁以及具有可读性。

列表推导式由包含一个表达式的括号组成，表达式后面跟随一个 `for` 子句，之后可以有零或多个 `for` 或 `if` 子句。结果是一个列表，由表达式依据其后面的 `for` 和 `if` 子句上下文计算而来的结果构成。

例如，如下的列表推导式结合两个列表的元素，如果元素之间不相等的话:
``` python
>>> [(x, y) for x in [1,2,3] for y in [3,1,4] if x != y]
[(1, 3), (1, 4), (2, 3), (2, 1), (2, 4), (3, 1), (3, 4)]
```
等同于:
``` python
>>> combs = []
>>> for x in [1,2,3]:
...     for y in [3,1,4]:
...         if x != y:
...             combs.append((x, y))
...
>>> combs
[(1, 3), (1, 4), (2, 3), (2, 1), (2, 4), (3, 1), (3, 4)]
```
值得注意的是在上面两个方法中的 `for` 和 `if` 语句的顺序。
``` python
>>> vec = [-4, -2, 0, 2, 4]
>>> # create a new list with the values doubled
>>> [x*2 for x in vec]
[-8, -4, 0, 4, 8]
>>> # filter the list to exclude negative numbers
>>> [x for x in vec if x >= 0]
[0, 2, 4]
>>> # apply a function to all the elements
>>> [abs(x) for x in vec]
[4, 2, 0, 2, 4]
>>> # call a method on each element
>>> freshfruit = ['  banana', '  loganberry ', 'passion fruit  ']
>>> [weapon.strip() for weapon in freshfruit]
['banana', 'loganberry', 'passion fruit']
>>> # create a list of 2-tuples like (number, square)
>>> [(x, x**2) for x in range(6)]
[(0, 0), (1, 1), (2, 4), (3, 9), (4, 16), (5, 25)]
>>> # the tuple must be parenthesized, otherwise an error is raised
>>> [x, x**2 for x in range(6)]
  File "<stdin>", line 1, in ?
    [x, x**2 for x in range(6)]
               ^
SyntaxError: invalid syntax
>>> # flatten a list using a listcomp with two 'for'
>>> vec = [[1,2,3], [4,5,6], [7,8,9]]
>>> [num for elem in vec for num in elem]
[1, 2, 3, 4, 5, 6, 7, 8, 9]
```

### del 语句

有个方法可以从列表中按给定的索引而不是值来删除一个子项： `del` 语句。它不同于有返回值的 `pop()` 方法。语句 `del` 还可以从列表中删除切片或清空整个列表（我们以前介绍过一个方法是将空列表赋值给列表的切片）。例如:
``` python
>>> a = [-1, 1, 66.25, 333, 333, 1234.5]
>>> del a[0]
>>> a
[1, 66.25, 333, 333, 1234.5]
>>> del a[2:4]
>>> a
[1, 66.25, 1234.5]
>>> del a[:]
>>> a
[]
```

## 集合

Python 还包含了一个数据类型 —— `set` （集合）。集合是一个无序不重复元素的集。基本功能包括关系测试和消除重复元素。集合对象还支持 `union`（联合），`intersection`（交），`difference`（差）和 `sysmmetric difference`（对称差集）等数学运算。

大括号或 `set()` 函数可以用来创建集合。注意：想要创建空集合，你必须使用 `set()` 而不是 `{}`。后者用于创建空字典，我们在下一节中介绍的一种数据结构。

以下是一个简单的演示:

``` python
>>> basket = {'apple', 'orange', 'apple', 'pear', 'orange', 'banana'}
>>> print(basket)                      # show that duplicates have been removed
{'orange', 'banana', 'pear', 'apple'}
>>> 'orange' in basket                 # fast membership testing
True
>>> 'crabgrass' in basket
False

>>> # Demonstrate set operations on unique letters from two words
...
>>> a = set('abracadabra')
>>> b = set('alacazam')
>>> a                                  # unique letters in a
{'a', 'r', 'b', 'c', 'd'}
>>> a - b                              # letters in a but not in b
{'r', 'd', 'b'}
>>> a | b                              # letters in either a or b
{'a', 'c', 'r', 'd', 'b', 'm', 'z', 'l'}
>>> a & b                              # letters in both a and b
{'a', 'c'}
>>> a ^ b                              # letters in a or b but not both
{'r', 'd', 'b', 'm', 'z', 'l'}
```
类似 for lists，这里有一种集合推导式语法:
``` python
>>> a = {x for x in 'abracadabra' if x not in 'abc'}
>>> a
{'r', 'd'}
```

## 字典

一个小示例:
``` python
>>> tel = {'jack': 4098, 'sape': 4139}
>>> tel['guido'] = 4127
>>> tel
{'sape': 4139, 'guido': 4127, 'jack': 4098}
>>> tel['jack']
4098
>>> del tel['sape']
>>> tel['irv'] = 4127
>>> tel
{'guido': 4127, 'irv': 4127, 'jack': 4098}
>>> list(tel.keys())
['irv', 'guido', 'jack']
>>> sorted(tel.keys())
['guido', 'irv', 'jack']
>>> 'guido' in tel
True
>>> 'jack' not in tel
False
```

`dict()` 构造函数可以直接从 `key-value` 对中创建字典:
``` python
>>> dict([('sape', 4139), ('guido', 4127), ('jack', 4098)])
{'sape': 4139, 'jack': 4098, 'guido': 4127}
```
此外，字典推导式可以从任意的键值表达式中创建字典:
``` python
>>> {x: x**2 for x in (2, 4, 6)}
{2: 4, 4: 16, 6: 36}
```
如果关键字都是简单的字符串，有时通过关键字参数指定 `key-value` 对更为方便:
``` python
>>> dict(sape=4139, guido=4127, jack=4098)
{'sape': 4139, 'jack': 4098, 'guido': 4127}
```
## 循环技巧

在字典中循环时，关键字和对应的值可以使用 `iteritems()` 方法同时解读出来:
``` python
>>> knights = {'gallahad': 'the pure', 'robin': 'the brave'}
>>> for k, v in knights.items():
...     print(k, v)
...
gallahad the pure
robin the brave
```
在序列中循环时，索引位置和对应值可以使用 `enumerate()` 函数同时得到:
``` python
>>> for i, v in enumerate(['tic', 'tac', 'toe']):
...     print(i, v)
...
0 tic
1 tac
2 toe
```
同时循环两个或更多的序列，可以使用 `zip()` 整体打包:
``` python
>>> questions = ['name', 'quest', 'favorite color']
>>> answers = ['lancelot', 'the holy grail', 'blue']
>>> for q, a in zip(questions, answers):
...     print('What is your {0}?  It is {1}.'.format(q, a))
...
What is your name?  It is lancelot.
What is your quest?  It is the holy grail.
What is your favorite color?  It is blue.
```
需要逆向循环序列的话，先正向定位序列，然后调用 `reversed()` 函数:
``` python
>>> for i in reversed(range(1, 10, 2)):
...     print(i)
...
9
7
5
3
1
```
要按排序后的顺序循环序列的话，使用 `sorted()` 函数，它不改动原序列，而是生成一个新的已排序的序列:
``` python
>>> basket = ['apple', 'orange', 'apple', 'pear', 'orange', 'banana']
>>> for f in sorted(set(basket)):
...     print(f)
...
apple
banana
orange
pear
```

## 短路操作符

逻辑操作符 `and` 和 `or` 也称作短路操作符：它们的参数从左向右解析，一旦结果可以确定就停止。例如，如果 A 和 C 为真而 B 为假， `A and B and C` 不会解析 C。作用于一个普通的非逻辑值时，短路操作符的返回值通常是最后一个变量。

## 模块

除了包含函数定义外，模块也可以包含可执行语句。这些语句一般用来初始化模块。他们仅在 第一次 被导入的地方执行一次。

每个模块都有自己 **私有的符号表**，被模块内所有定义的函数作为全局符号表使用。因此，模块的作者可以在模块内部使用全局变量，而无需担心它与某个用户的全局变量意外冲突

### 作为脚本来执行模块

当你使用以下方式运行 Python 模块时，模块中的代码便会被执行:
``` python
python fibo.py <arguments>
```
模块中的代码会被执行，就像导入它一样，不过此时 `__name__ `被设置为 `__main__`。这相当于，如果你在模块后加入如下代码:
``` python
if __name__ == "__main__":
    import sys
    fib(int(sys.argv[1]))
```
就可以让此文件像作为模块导入时一样作为脚本执行。此代码只有在模块作为 “main” 文件执行时才被调用:
``` python
$ python fibo.py 50
1 1 2 3 5 8 13 21 34
```
如果模块被导入，不会执行这段代码:
``` pythopn
>>> import fibo
>>>
```
这通常用来为模块提供一个便于测试的用户接口（将模块作为脚本执行测试需求）。

### 模块的搜索路径
1. 输入脚本的目录（当前目录）。
2. 环境变量 `PYTHONPATH` 表示的目录列表中搜索 (这和 `shell `变量 `PATH` 具有一样的语法，即一系列目录名的列表)。
3. `Python` 默认安装路径中搜索。


## 包

需要注意的是使用 `from package import item` 方式导入包时，这个子项（`item`）既可以是包中的一个子模块（或一个子包），也可以是包中定义的其它命名，像函数、类或变量。`import` 语句首先核对是否包中有这个子项，如果没有，它假定这是一个模块，并尝试加载它。如果没有找到它，会引发一个 `ImportError` 异常。

相反，使用类似 `import item.subitem.subsubitem` 这样的语法时，这些子项必须是包，最后的子项可以是包或模块，但不能是前面子项中定义的类、函数或变量。

``` python
sound/                          Top-level package
      __init__.py               Initialize the sound package
      formats/                  Subpackage for file format conversions
              __init__.py
              wavread.py
              wavwrite.py
              aiffread.py
              aiffwrite.py
              auread.py
              auwrite.py
              ...
      effects/                  Subpackage for sound effects
              __init__.py
              echo.py
              surround.py
              reverse.py
              ...
      filters/                  Subpackage for filters
              __init__.py
              equalizer.py
              vocoder.py
              karaoke.py
              ...
```

###  `from Sound.Effects import *`

`sounds/effects/__init__.py` 这个文件可能包括如下代码:
``` python
__all__ = ["echo", "surround", "reverse"]
```
这意味着 `from Sound.Effects import *` 语句会从 `sound` 包中导入以上三个已命名的子模块。

### 使用相对路径导入

以 `surround` 模块为例，你可以这样用:
```
from . import echo
from .. import formats
from ..filters import equalizer
```

## str.format()
``` python
>>> print('We are the {} who say "{}!"'.format('knights', 'Ni'))
We are the knights who say "Ni!"
```
大括号和其中的字符会被替换成传入 `str.format()` 的参数。大括号中的数值指明使用传入 `str.format()` 方法的对象中的哪一个:
``` python
>>> print('{0} and {1}'.format('spam', 'eggs'))
spam and eggs
>>> print('{1} and {0}'.format('spam', 'eggs'))
eggs and spam
```
如果在 `str.format()` 调用时使用关键字参数，可以通过参数名来引用值:
``` python
>>> print('This {food} is {adjective}.'.format(
...       food='spam', adjective='absolutely horrible'))
This spam is absolutely horrible.
```
定位和关键字参数可以组合使用:
``` python
>>> print('The story of {0}, {1}, and {other}.'.format('Bill', 'Manfred',                                                other='Georg'))
The story of Bill, Manfred, and Georg.
```
`!a` (应用 `ascii()`)，`!s` （应用 `str()`）和 `!r` （应用 `repr()` ）可以在格式化之前转换值:
``` python
>>> import math
>>> print('The value of PI is approximately {}.'.format(math.pi))
The value of PI is approximately 3.14159265359.
>>> print('The value of PI is approximately {!r}.'.format(math.pi))
The value of PI is approximately 3.141592653589793.
```
字段名后允许可选的 `:` 和格式指令。这允许对值的格式化加以更深入的控制。下例将 `Pi` 转为三位精度。
``` python
>>> import math
>>> print('The value of PI is approximately {0:.3f}.'.format(math.pi))
The value of PI is approximately 3.142.
```
在字段后的 `:` 后面加一个整数会限定该字段的最小宽度，这在美化表格时很有用:
``` python
>>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 7678}
>>> for name, phone in table.items():
...     print('{0:10} ==> {1:10d}'.format(name, phone))
...
Jack       ==>       4098
Dcab       ==>       7678
Sjoerd     ==>       4127
```
如果你有个实在是很长的格式化字符串，不想分割它。如果你可以用命名来引用被格式化的变量而不是位置就好了。有个简单的方法，可以传入一个字典，用中括号访问它的键:
``` python
>>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
>>> print('Jack: {0[Jack]:d}; Sjoerd: {0[Sjoerd]:d}; '
          'Dcab: {0[Dcab]:d}'.format(table))
Jack: 4098; Sjoerd: 4127; Dcab: 8637678
```
也可以用 `**` 标志将这个字典以关键字参数的方式传入:
``` python
>>> table = {'Sjoerd': 4127, 'Jack': 4098, 'Dcab': 8637678}
>>> print('Jack: {Jack:d}; Sjoerd: {Sjoerd:d}; Dcab: {Dcab:d}'.format(**table))
Jack: 4098; Sjoerd: 4127; Dcab: 8637678
```
这种方式与新的内置函数 `vars()` 组合使用非常有效。该函数返回包含所有局部变量的字典。

##异常

### 用户自定义异常

在程序中可以通过创建新的异常类型来命名自己的异常（Python 类的内容请参见 类 ）。异常类通常应该直接或间接的从 `Exception` 类派生，例如:

``` python
>>> class MyError(Exception):
...     def __init__(self, value):
...         self.value = value
...     def __str__(self):
...         return repr(self.value)
...
>>> try:
...     raise MyError(2*2)
... except MyError as e:
...     print('My exception occurred, value:', e.value)
...
My exception occurred, value: 4
>>> raise MyError('oops!')
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
__main__.MyError: 'oops!'
```
在这个例子中，`Exception` 默认的 `__init__()` 被覆盖。新的方式简单的创建 `value` 属性。这就替换了原来创建 `args` 属性的方式。

异常类中可以定义任何其它类中可以定义的东西，但是通常为了保持简单，只在其中加入几个属性信息，以供异常处理句柄提取。如果一个新创建的模块中需要抛出几种不同的错误时，一个通常的作法是为该模块定义一个异常基类，然后针对不同的错误类型派生出对应的异常子类:
``` python
class Error(Exception):
    """Base class for exceptions in this module."""
    pass

class InputError(Error):
    """Exception raised for errors in the input.

    Attributes:
        expression -- input expression in which the error occurred
        message -- explanation of the error
    """

    def __init__(self, expression, message):
        self.expression = expression
        self.message = message

class TransitionError(Error):
    """Raised when an operation attempts a state transition that's not
    allowed.

    Attributes:
        previous -- state at beginning of transition
        next -- attempted new state
        message -- explanation of why the specific transition is not allowed
    """

    def __init__(self, previous, next, message):
        self.previous = previous
        self.next = next
        self.message = message
```
与标准异常相似，大多数异常的命名都以 `Error` 结尾。

很多标准模块中都定义了自己的异常，用以报告在他们所定义的函数中可能发生的错误。关于类的进一步信息请参见 类 一章。

### 定义清理行为
`try` 语句还有另一个可选的子句，目的在于定义在任何情况下都一定要执行的功能。例如:
``` python
>>> try:
...     raise KeyboardInterrupt
... finally:
...     print('Goodbye, world!')
...
Goodbye, world!
KeyboardInterrupt
```

不管有没有发生异常，`finally` 子句 在程序离开 `try` 后都一定会被执行。当 `try` 语句中发生了未被 `except` 捕获的异常（或者它发生在 `except` 或 `else` 子句中），在 `finally` 子句执行完后它会被重新抛出。 `try` 语句经由 `break` ，`continue` 或 `return` 语句退 出也一样会执行 `finally` 子句。以下是一个更复杂些的例子（在同 一个 `try` 语句中的 `except` 和 `finally` 子句的工作方式与 Python 2.5 一样）:
``` python
>>> def divide(x, y):
...     try:
...         result = x / y
...     except ZeroDivisionError:
...         print("division by zero!")
...     else:
...         print("result is", result)
...     finally:
...         print("executing finally clause")
...
>>> divide(2, 1)
result is 2
executing finally clause
>>> divide(2, 0)
division by zero!
executing finally clause
>>> divide("2", "1")
executing finally clause
Traceback (most recent call last):
  File "<stdin>", line 1, in ?
  File "<stdin>", line 3, in divide
TypeError: unsupported operand type(s) for /: 'str' and 'str'
```
如你所见， `finally` 子句在任何情况下都会执行。`TypeError` 在两个字符串相除的时候抛出，未被 `except` 子句捕获，因此在 `finally` 子句执行完毕后重新抛出。

在真实场景的应用程序中，`finally` 子句用于释放外部资源（文件 或网络连接之类的），无论它们的使用过程中是否出错。

### 预定义清理行为

``` python
with open("myfile.txt") as f:
    for line in f:
        print(line)
```
语句执行后，文件 `f` 总会被关闭，即使是在处理文件中的数据时出错也一样。其它对象是否提供了预定义的清理行为要查看它们的文档。

# TODO

## unicode
## pickle
## file
---

```
要配制成默认的话，需要创建或修改配置文件（linux的文件在~/.pip/pip.conf，windows在%HOMEPATH%\pip\pip.ini），修改内容为：
code:
[global]
index-url = http://pypi.douban.com/simple
```

```python
def judgePasswordStrength(password):
    strengthLength = max(0, len(password) - 5)
    from string import ascii_lowercase, ascii_uppercase, digits, punctuation
    flags = [bool(set(password) & set(s)) \
            for s in [ascii_lowercase, ascii_uppercase, digits, punctuation]]
    return min(flags.count(True), strengthLength)
```

# other


## python3 special

- print

```
用一个逗号结尾就可以禁止输出换行:
>>> a, b = 0, 1
>>> while b < 1000:
...     print(b, end=',') # notice here
...     a, b = b, a+b
...
1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,
```

## dubug Python

```python
def demo():
    _pdb = True
    num = 10
    if num > 5:
        if _pdb == True:
            import pdb
            pdb.set_trace()

    print num
```

| 操作          | 说明|
----------------|-----|
| b or break    | 设置断点|
| c or continue	| 继续执行程序|
| l or list	    | 查看当前行的代码段|
| s or step	    | 进入函数|
| r or return	| 执行代码直到从当前函数返回|
| p or pp       | 打印变量的值|
| n or next	    | 执行下一行|
| q or exit     | 中止并退出|
| help	        | 帮助|

##virtualenv

> $ sudo apt-get install python-pip python-dev build-essential

> $ sudo pip install --upgrade pip

> $ sudo pip install --upgrade virtualenv

> 使用 Virtualenv 的理由：
> 1、隔离项目之间的第三方包依赖，如A项目依赖django1.2.5，B项目依赖django1.3。
> 2、为部署应用提供方便，把开发环境的虚拟环境打包到生产环境即可,不需要在服务器上再折腾一翻。

    1、安装pip
    $ sudo apt-get install python-pip

    2、安装virtualenv
    $ sudo pip install virtualenv

    3、创建一个隔离环境
    $ virtualenv test

    4、激活隔离环境
    $ source test/bin/activate

    5、我们就可以看到在命令行的前面已经加上了(test)，这个时候我们看看python所指向的路径：
    $ which python

    6、安装django1.5.1，不要加sudo
    $ pip install Django==1.5.1

    7、运行python，键入import django，回车，没报错就是安装好了。

    8、若要退出虚拟环境
    $ deactivate

## and or 逻辑演算

> 在 Python 中，and 和 or 按照下面的规则执行布尔逻辑演算：
>
> 对于 and，从左到右运算：
>
> 如果所有表达式都为真，则 and 返回最后一个表达式。
> 否则，and 返回第一个假值。
> 对于 or，从左到右运算：
>
> 如果有一个为真，则 or 立刻返回该值。
> 否则，or 返回最后一个表达式。
> or 找到第一个真值后会忽略计算剩余的表达式。
> 注意到：返回的并不是布尔值，而是其中某个参与比较的表达式值。

## Python Code Snippets

```
第4章 Python对象
完整熟练
6.8 Unicode
完整熟练
8.11 迭代器和iter()函数
完整熟练
第9章 文件的输入和输出
完整熟练
第10章 错误和异常
完整熟练
第11章 函数和函数式编程
完整熟练
第12章 模块
完整熟练
第14章 执行环境
完整熟练
第15章 正则表达式
idea 完整熟练
第18章 多线程编程
完整熟练
20.2 使用Python进行Web应用：创建一个简单的Web客户端
完整熟练
```

## max()

```
>>> lis = [(1,'a'),(3,'c'), (4,'e'), (-1,'z')]
>>> max(lis)
(4, 'e')
>>> max(lis, key = lambda x:x[1])
(-1, 'z')
```

```
>>> lis = ['1','100','111','2', 2, 2.57]
>>> max(lis) #works in py2.x
'2'
>>> max(lis, key=lambda x:int(x)) #compare integer version of each item
'111'
```

- http://forums.udacity.com/questions/5000048/how-to-use-key
- http://stackoverflow.com/questions/18296755/python-max-function-using-key-and-lambda-expression
- http://code.activestate.com/recipes/389659-min-and-max-with-key-argument/
- https://wiki.python.org/moin/HowTo/Sorting

## Python单步调试

在需要单步调试的地方加上面这句，运行程序后中断在此，然后h查看指令进行一步步细细调试

```
import pdb;
pdb.set_trace()
```

## 装饰器

Python 会将 `login` 的参数直接传给 `__decorator` 这个函数。我们可以直接在 `__decorator` 中使用 `user` 变量
```
def printdebug(func):
    def __decorator(user):    # add parameter receive the user information
        print('enter the login')
        func(user)  # pass user to login
        print('exit the login')
    return __decorator

@printdebug
def login(user):
    print('in login:' + user)

login('jatsz')  # arguments:jatsz
```

装饰有返回值的函数
```
def printdebug(func):
    def __decorator(user):
        print('enter the login')
        result = func(user)  #recevie the native function call result
        print('exit the login')
        return result        #return to caller
    return __decorator

@printdebug
def login(user):
    print('in login:' + user)
    msg = "success" if user == "jatsz" else "fail"
    return msg  #login with a return value

result1 = login('jatsz');
print result1  #print login result

result2 = login('candy');
print result2
```

## Lambda, filter, reduce and map

- lambda
```
>>> f = lambda x, y : x + y
>>> f(1,1)
2
```

- map
```
>>> Celsius = [39.2, 36.5, 37.3, 37.8]
>>> Fahrenheit = map(lambda x: (float(9)/5)*x + 32, Celsius)
>>> print Fahrenheit
[102.56, 97.700000000000003, 99.140000000000001, 100.03999999999999]
>>> C = map(lambda x: (float(5)/9)*(x-32), Fahrenheit)
>>> print C
[39.200000000000003, 36.5, 37.300000000000004, 37.799999999999997]
>>>
```
```
>>> a = [1,2,3,4]
>>> b = [17,12,11,10]
>>> c = [-1,-4,5,9]
>>> map(lambda x,y:x+y, a,b)
[18, 14, 14, 14]
>>> map(lambda x,y,z:x+y+z, a,b,c)
[17, 10, 19, 23]
>>> map(lambda x,y,z:x+y-z, a,b,c)
[19, 18, 9, 5]
```

- filter
```
>>> fib = [0,1,1,2,3,5,8,13,21,34,55]
>>> result = filter(lambda x: x % 2, fib)
>>> print result
[1, 1, 3, 5, 13, 21, 55]
>>> result = filter(lambda x: x % 2 == 0, fib)
>>> print result
[0, 2, 8, 34]
>>>
```

- reduce
```
>>> f = lambda a,b: a if (a > b) else b
>>> reduce(f, [47,11,42,102,13])
102
>>>
Calculating the sum of the numbers from 1 to 100:
>>> reduce(lambda x, y: x+y, range(1,101))
5050
```

## 多继承机制（mro：method resolution orde）

### 说明

- 如果继承至一个基类：`class B(A)`
> 这时B的mro序列为[B,A]

- 如果继承至多个基类：`class B(A1,A2,A3 ...)`
>这时B的mro序列 mro(B) = [B] + merge(mro(A1), mro(A2), mro(A3) ..., [A1,A2,A3])

- merge操作就是C3算法的核心。
1. 遍历执行merge操作的序列，如果一个序列的第一个元素，在其他序列中也是第一个元素，或不在其他序列出现，则从所有执行merge操作序列中删除这个元素，合并到当前的mro中。
2. merge操作后的序列，继续执行merge操作，直到merge操作的序列为空。
如果merge操作的序列无法为空，则说明不合法。

- 例子：
```
class A(O):pass
class B(O):pass
class C(O):pass
class E(A,B):pass
class F(B,C):pass
class G(E,F):pass
```

A、B、C都继承至一个基类，所以mro序列依次为[A,O]、[B,O]、[C,O]
```
mro(E) = [E] + merge(mro(A), mro(B), [A,B])
       = [E] + merge([A,O], [B,O], [A,B])
```
执行merge操作的序列为[A,O]、[B,O]、[A,B]。A是序列[A,O]中的第一个元素，在序列[B,O]中不出现，在序列[A,B]中也是第一个元素，所以从执行merge操作的序列([A,O]、[B,O]、[A,B])中删除A，合并到当前mro，[E]中。
```
mro(E) = [E,A] + merge([O], [B,O], [B])
```
再执行merge操作，O是序列[O]中的第一个元素，但O在序列[B,O]中出现并且不是其中第一个元素。
继续查看[B,O]的第一个元素B，B满足条件，所以从执行merge操作的序列中删除B，合并到[E, A]中。
```
mro(E) = [E,A,B] + merge([O], [O])
       = [E,A,B,O]
```
同理
```
mro(F) = [F] + merge(mro(B), mro(C), [B,C])
       = [F] + merge([B,O], [C,O], [B,C])
       = [F,B] + merge([O], [C,O], [C])
       = [F,B,C] + merge([O], [O])
       = [F,B,C,O]
```
```
mro(G) = [G] + merge(mro[E], mro[F], [E,F])
       = [G] + merge([E,A,B,O], [F,B,C,O], [E,F])
       = [G,E] + merge([A,B,O], [F,B,C,O], [F])
       = [G,E,A] + merge([B,O], [F,B,C,O], [F])
       = [G,E,A,F] + merge([B,O], [B,C,O])
       = [G,E,A,F,B] + merge([O], [C,O])
       = [G,E,A,F,B,C] + merge([O], [O])
       = [G,E,A,F,B,C,O]
```
### 示例

```python
class A(object):
    def __init__(self):
        print "enter A"
        super(A, self).__init__()
        print "leave A"

class B(object):
    def __init__(self):
        print "enter B"
        super(B, self).__init__()
        print "leave B"

class C(A):
    def __init__(self):
        print "enter C"
        super(C, self).__init__()
        print "leave C"

class D(A):
    def __init__(self):
        print "enter D"
        super(D, self).__init__()
        print "leave D"

class E(B, C):
    def __init__(self):
        print "enter E"
        super(E, self).__init__()
        print "leave E"

class F(E, D):
    def __init__(self):
        print "enter F"
        super(F, self).__init__()
        print "leave F"

f = F()
```
- 初始化顺序为： `F－>E－>B－>C－>D－>A`
- mro[F] = [FEBCDA]
- 输出为
```
enter F
enter E
enter B
enter C
enter D
enter A
leave A
leave D
leave C
leave B
leave E
leave F
````

## image module

``` Python
try:
 from cStringIO import StringIO
except ImportError:
 from StringIO import StringIO

img = Image.open(content)

#Make a thing to hold our data
o = StringIO()

#convert the image to a binary file-like memory object
img.save(o,'PNG')

# We NEED this object because it has 'chunks'
content = ContentFile(o.getvalue())

super( CustomImageStorage,self).save(name, content)
```

## `V1 if X else V2`


## test seahub

`py.test tests/api/test_accounts.py::AccountsApiTest::test_update_account_intro`


## log
``` python
import logging
logging.basicConfig(
       filename = ('/tmp/lian.log'),
       level = logging.INFO,
       filemode = 'w',
       format = '[%(filename)s:%(lineno)d] %(asctime)s - %(levelname)s: %(message)s'
   )

logging.error(e)
```
