## Regex

|符号	 |匹配|
---------|----|
|.(dot)	 |任意单一字符
|\d	 |任意一位数字
|[A-Z]	 |A 到 Z中任意一个字符（大写）
|[a-z]	 |a 到 z中任意一个字符（小写）
|[A-Za-z]|a 到 z中任意一个字符（不区分大小写）
|+       |匹配一个或更多 (例如, \d+ 匹配一个或 多个数字字符)
|[^/]+	 |一个或多个不为‘/’的字符
|?	 |零个或一个之前的表达式（例如：\d? 匹配零个或一个数字）
|*	 |匹配0个或更多 (例如, \d* 匹配0个 或更多数字字符)
|{1,3}	 |介于一个和三个（包含）之前的表达式（例如，\d{1,3}匹配一个或两个或三个数字）

[regex.png](Images/regex.png)
