[toc]

# 编码

## 编码基础知识

### ASCII码

每一个二进制位（bit）有0和1两种状态，因此八个二进制位就可以组合出256种状态，这被称为一个字节（byte）。也就是说，一个字节一共可以用来表示256种不同的状态，每一个状态对应一个符号，就是256个符号，从0000000到11111111。

ASCII码，制定英语字符与二进制位之间的关系。

一共规定了128个字符的编码，比如空格"SPACE"是32（二进制00100000），大写的字母A是65（二进制01000001）。这128个符号（包括32个不能打印出来的控制符号），只占用了一个字节的后面7位，最前面的1位统一规定为0。

ASCII码只能表示有限的符号，不能表示所有符号。

### Unicode

Unicode，用一个十六进制数，表示所有符号的编码，每个符号的编码都不一样。比如，`U+0639` 表示阿拉伯字母Ain，`U+0041` 表示英语的大写字母A，`U+4E25` 表示汉字"严"。

Unicode 只是一个符号集，只规定了符号的十六进制数即相应的二进制代码，却没有规定这个二进制代码应该如何存储。

Unicode的问题：

1. 如何才能区别Unicode和ASCII？计算机怎么知道三个字节表示一个符号，而不是分别表示三个符号呢？

2. 英文字母只用一个字节表示就够了，如果Unicode统一规定，每个符号用三个或四个字节表示，那么每个英文字母前都必然有二到三个字节是0，这对于存储来说是极大的浪费。

> ASCII 和 Unicode 本质上是一样的概念，只是所表示的范围不一样。

### UTF-8

UTF-8，一种变长的编码方式，通过制定规则，解决上述问题：

1. 对于单字节的符号，字节的第一位设为0，后面7位为这个符号的unicode码。因此对于英语字母，UTF-8编码和ASCII码是相同的。

2. 对于n字节的符号（n>1），第一个字节的前n位都设为1，第n+1位设为0，后面字节的前两位一律设为10。剩下的没有提及的二进制位，全部为这个符号的unicode码。

Unicode符号范围（十六进制） | UTF-8编码方式（二进制）
-|-
0000 0000-0000 007F | 0xxxxxxx
0000 0080-0000 07FF | 110xxxxx 10xxxxxx
0000 0800-0000 FFFF | 1110xxxx 10xxxxxx 10xxxxxx
0001 0000-0010 FFFF | 11110xxx 10xxxxxx 10xxxxxx 10xxxxxx

跟据上表，解读UTF-8编码非常简单：

1. 如果一个字节的第一位是0，则这个字节单独就是一个字符；

2. 如果第一位是1，则连续有多少个1，就表示当前字符占用多少个字节。

下面，还是以汉字"严"为例，演示如何实现UTF-8编码。

已知"严"的unicode是4E25（100111000100101），根据上表，可以发现4E25处在第三行的范围内（0000 0800-0000 FFFF），因此"严"的UTF-8编码需要三个字节，即格式是"1110xxxx 10xxxxxx 10xxxxxx"。然后，从"严"的最后一个二进制位开始，依次从后向前填入格式中的x，多出的位补0。这样就得到了，"严"的UTF-8编码是"11100100 10111000 10100101"，转换成十六进制就是E4B8A5。

## JS 中的编码

主要指URL中的编码：

> "...Only alphanumerics [0-9a-zA-Z], the special characters "$-_.+!*'()," [not including the quotes - ed], and reserved characters used for their reserved purposes may be used unencoded within a URL."
> 
> "只有字母和数字`[0-9a-zA-Z]`、一些特殊符号 `$-_.+!*'(),`、以及某些保留字，才可以不经过编码直接用于URL。"

由于各种操作系统默认、浏览器默认、网页编码都不同，所以一律使用Javascript先对URL编码（经过JS编码后的字符，均为Unicode字符），然后再向服务器提交。

> 最终发给服务器的 URI 用 UTF-8 编码

### escape

> NOTE:
> This feature has been removed from the Web standards. Though some browsers may still support it, it is in the process of being dropped. Do not use it in old or new projects. Pages or Web apps using it may break at any time.

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/escape


### encodeURI(URI)

The `encodeURI()` method encodes a Uniform Resource Identifier (URI) . `URI`, A complete Uniform Resource Identifier.

Assumes that the URI is a complete URI, so does not encode reserved characters that have special meaning in the URI.encodeURI replaces all characters except the following with the appropriate UTF-8 escape sequences:

Type | Includes
-|-
Reserved characters | ; , / ? : @ & = + $
Unescaped characters | alphabetic, decimal digits, - _ . ! ~ * ' ( )
Score | #

Note that encodeURI by itself cannot form proper HTTP GET and POST requests, such as for XMLHTTPRequests, because `&`, `+`, and `=` are not encoded, which are treated as special characters in GET and POST requests. encodeURIComponent, however, does encode these characters.

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURI

### encodeURIComponent(str)

The `encodeURIComponent()` method encodes a Uniform Resource Identifier (URI) component. `str` String. A component of a URI.

encodeURIComponent escapes all characters except the following: `alphabetic`,  `decimal digits`,  `- _ . ! ~ * ' ( )`.

To avoid unexpected requests to the server, you should call encodeURIComponent on any user-entered parameters that will be passed as part of a URI. 

For example, a user could type `Thyme &time=again` for a variable comment. Not using encodeURIComponent on this variable will give `comment=Thyme%20&time=again`. Note that the ampersand and the equal sign mark a new key and value pair. So instead of having a POST comment key equal to `Thyme &time=again`, you have two POST keys, one equal to `Thyme ` and another (`time`) equal to `again`.

For **application/x-www-form-urlencoded**, spaces are to be replaced by `+`, so one may wish to follow a encodeURIComponent replacement with an additional replacement of `%20` with `+`.

- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent

## Python 中的编码
















- http://www.ruanyifeng.com/blog/2007/10/ascii_unicode_and_utf-8.html
- http://www.ruanyifeng.com/blog/2010/02/url_encoding.html
- https://unspecified.wordpress.com/2008/05/24/uri-encoding/
