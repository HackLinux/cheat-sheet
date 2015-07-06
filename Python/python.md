# Python

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

## Code Snippet

- `DATABASE_NAME=os.path.join(os.path.dirname(__file__),'myAPP/mydata.db')`
其中 os.path.dirname(__file__)函数用于取出settings.py所在文件夹的位置，在用os.path.join()函数将该位置和后面指定的'myAPP/mydata.db'  字符串连接一起，实现sqlite3数据库文件mydata.db具体存放的位置。

`repo_share_group = filter(lambda i: i.repo_id == repo_id, repo_share_group)`

# Python Code Snippets

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

#### max()

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

#### Python单步调试

在需要单步调试的地方加上面这句，运行程序后中断在此，然后h查看指令进行一步步细细调试

```
import pdb;
pdb.set_trace()
```

#### 装饰器

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




#### Lambda, filter, reduce and map

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

#### 多继承机制（mro：method resolution orde）

###### 说明

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
###### 示例

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
