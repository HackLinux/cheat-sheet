# JS

## Jquery.ajax()

[Jquery Ajax document](http://api.jquery.com/jquery.ajax/)

```
$.ajax({
    /* ajax options omitted */
    error: function (xmlHttpRequest, textStatus, errorThrown) {
         if(xmlHttpRequest.readyState == 0 || xmlHttpRequest.status == 0)
              return;  // it's not really an error
         else
              // Do normal error handling
});
```

> ajax request may gets canceled before it completes. jQuery throws the error event when the user navigates away from the page either by refreshing, clicking a link, or changing the URL in the browser. You can detect these types of errors by by implementing an error handler for the ajax call, and inspecting the xmlHttpRequest object


## hasOwnProperty

```
var man = {
   hands: 2,
   legs: 2,
   heads: 1
};
for (var i in man) {
   if (Object.prototype.hasOwnProperty.call(man, i)) { // filter
      console.log(i, ":", man[i]);
   }
}
```

## Switch

```
var inspect_me = 0,
    result = '';
switch (inspect_me) {
case 0:
   result = "zero";
   break;
case 1:
   result = "one";
   break;
default:
   result = "unknown";
}
```
1. 将case和switch对齐;
1. case的内容缩进;
1. 每一个case之后都有一个清晰的break;避免顺序往下执行case，11. 非要如此的话，文档一定要写清楚;
1. 最后使用default，保证在没有命中case的情况下也有反馈

### 避免隐藏的类型转换

Javascript在你比较两个变量的时候会进行类型的转换，这就是为什么 false == 0或者”” == 0会返回true。

为了避免这种隐藏的类型转换带来的迷惑，最好使用===或者!==操作符来比较：

```
var zero = 0;
if (zero === false) {
   // not executing because zero is 0, not false
}
// antipattern
if (zero == false) {
   // this block is executed...
}
```

## parseInt()转换处理数字

使用 `parseInt()` 你可以将字符串转为数字。这个方法支持第二个表示进制的参数，常常被忽略。问题常常在处理一段以 `0` 开始的字符串的时候。在ECMAS3标准中，以 `0` 开始表示八进制，但是在ES5中又改了，所以为了避免麻烦，最好还是标明第二个参数。
```
var month = "06",
    year = "09";
month = parseInt(month, 10);
year = parseInt(year, 10);
```
在这个例子中，如果你使用 `parseInt(year)`，就会返回 `0`，因为 `09` 被认为是8进制数字，然而9是非法的八进制字符，所以返回 `0`。

其他的可以把字符串转为数字的方法有：
```
 +"08" // result is 8
Number("08") // 8
```
这些通常都比 `parseInt()` 快一些，因为 `parseInt` 并不只是简单的转换。但是如果你的输入是 `08 hello` 这样的，那么 `parseInt()` 也会返回 `8`，但是其他的方法就只能返回 `NaN`。

## 使用空格

1. 循环中的分号之后
1. 循环中的变量初始化 `for (var i = 0, max = 10; i < max; i += 1) {…}`
1. 数组中的逗号分隔符之后 `var a = [1, 2, 3];`
1. 对象字面量中的逗号 `var o = {a: 1, b: 2};`
1. 函数参数间 `myFunc(a, b, c)`
1. 在函数声明时候的大括号前面 `function myFunc() {}`
1. 匿名函数 `var myFunc = function () {};`
1. 另外一些使用空格比较好的地方就是在那些操作符的两边，比如 `+`, `-`, `*`, `=`, `<`, `>`, `<=`, `>=`, `===`, `!==`, `&&`, `||`, `+=`等等。

## 命名

1. 对于普通的函数，采用驼峰式 `myFunction()`， `calculateArea()`。
2. 变量使用下划线来区分：`first_name`, `favorite_bands`, 以及 `old_company_name`。让你一眼就能区分函数和变量。

## 001：Js 事件冒泡

#### 冒泡定义

当一个元素上的事件被触发的时候，比如说鼠标点击了一个按钮，同样的事件将会在那个元素的所有祖先元素中被触发。这一过程被称为事件冒泡；这个事件从原始元素开始一直冒泡到DOM树的最上层。

```JavaScript
<body onclick="alert('document')">
    <div id="outer" onclick="alert('outer');">
         <div id="inner" onclick="alert('inner')">
             <a id="link" href=http://www.it165.net onclick="alert('link')">Click</a>
         </div>
    </div>
</body>
```
上述代码运行后，点击链接，以此会出现link, inner, outer, document,转向百度。
也就是说我们点击链接后 click事件一直冒泡传递在最外层body。

#### 阻止事件冒泡, 并不阻止事件行为：event.stopPropagation();

```JavaScript
<script type="text/javascript">
	$(function() {
		$("#link").click(function(event) {
			event.stopPropagation();
		});
	});
</script>
```
上述代码运行后，点击链接，按顺序会出现link, 转向百度。

#### 阻止事件行为，并阻止事件冒泡 ：event.preventDefault();

```JavaScript
<script type="text/javascript">
	$(function() {
		$("#link").click(function(event) {
			event.preventDefault();
		});
	});
</script>
```
上述代码运行后，点击链接，按顺序会出现link, inner, outer, document, 但是不转向百度。

#### 阻止事件冒泡, 也阻止事件行为：return false;

```JavaScript
<script type="text/javascript">
	$(function() {
		$("#link").click(function(event) {
			return false;
		});
	});
</script>
```

#### 示例：jQuery实现鼠标点击Div区域外隐藏Div

```HTML
<div id="demo">
    <p>This is a div.</p>
    <p>This is a demo.</p>
</div>
<input id="btn" type="button" value="显示DIV" />
```

首先在document上添加一个点击隐藏Div的事件，然后分别在点击button和div的时候防止冒泡到document。

```
<script type="text/javascript">
$("#btn").click(function (event) {
	$("#demo").fadeIn();
	$(document).one("click", function () {//对document绑定一个影藏Div方法
		$("#demo").hide();
	});
	event.stopPropagation();//阻止事件冒泡到document
});
$("#demo").click(function (event) {
	event.stopPropagation();//在Div区域内的点击事件阻止冒泡到document
});
</script>
```

## 002：DOM Tree

    <HTML>
    <BODY>
    <table border="0" cellspacing="2" cellpadding="5">
       <tr>
          <td colspan="2"><img src="Greetings.jpg" id="greetingImg" /></td>
       </tr>
       <tr>
          <td>
             Welcome to my sample HTML page!
             <br />
             <a href="somelink.html" id="myLink" >Click Here!</a>
          </td>
          <td><img src="hello.jpg" id="helloImg" /></td>
       </tr>
    </table>
    </BODY>
    </HTML>

[[Js/js-pic/dom-tree.gif]]

## 003：call & apply

[here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/apply)
and
[here](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/call)

You can assign a different `this` object when calling an existing function. `this` refers to the current object, the calling object. With call(apply), you can write a method once and then inherit it in another object, without having to rewrite the method for the new object.

```
fun.apply(thisArg[, argsArray])
```
```
fun.call(thisArg[, arg1[, arg2[, ...]]])
```

> **Note**: While the syntax of this function is almost identical to that of `apply()`, the fundamental difference is that `call()` accepts an **argument list**, while `apply()` accepts a **single array of arguments**.

```
var animals = [
  { species: 'Lion', name: 'King' },
  { species: 'Whale', name: 'Fail' }
];

for (var i = 0; i < animals.length; i++) {
  (function(i) {
    this.print = function() {
      console.log('#' + i + ' ' + this.species
                  + ': ' + this.name);
    }
    this.print();
  }).call(animals[i], i);
}
```

```
/* min/max number in an array */
var numbers = [5, 6, 2, 3, 7];

/* using Math.min/Math.max apply */
var max = Math.max.apply(null, numbers); /* This about equal to Math.max(numbers[0], ...)
                                            or Math.max(5, 6, ...) */
var min = Math.min.apply(null, numbers);
```
> **But beware**: in using apply this way, you run the risk of exceeding the JavaScript engine's argument length limit. The consequences of applying a function with too many arguments (think more than tens of thousands of arguments) vary across engines (JavaScriptCore has hard-coded argument limit of 65536), because the limit (indeed even the nature of any excessively-large-stack behavior) is unspecified. Some engines will throw an exception. More perniciously, others will arbitrarily limit the number of arguments actually passed to the applied function. (To illustrate this latter case: if such an engine had a limit of four arguments [actual limits are of course significantly higher], it would be as if the arguments 5, 6, 2, 3 had been passed to apply in the examples above, rather than the full array.) If your value array might grow into the tens of thousands, use a hybrid strategy: apply your function to chunks of the array at a time:
```
function minOfArray(arr) {
  var min = Infinity;
  var QUANTUM = 32768;

  for (var i = 0, len = arr.length; i < len; i += QUANTUM) {
    var submin = Math.min.apply(null, arr.slice(i, Math.min(i + QUANTUM, len)));
    min = Math.min(submin, min);
  }

  return min;
}

var min = minOfArray([5, 6, 2, 3, 7]);
```
----------------------------------
在javascript OOP中，我们经常会这样定义：

```
function cat(){}

cat.prototype={
  food: "fish",
  say : function(){ alert("I love "+this.food);},
}
var blackCat = new cat;
blackCat.say();
```
有一个新对象，但不对新对象定义定义 `say` 方法
```
var whiteDog = {food:"bone"}
```
可以通过 `call` 或 `apply` 调用 `blackCat` 的 `say` 方法来实现：
```
blackCat.say.call(whiteDog)
```

再例如，我们可以通过：
```
var domNodes = Array.prototype.slice.call(document.getElementsByTagName("*"));
```
这样 `domNodes` 就可以应用 `Array` 下的所有方法，如 `push`，`pop`等。

- `JavaScript` 的函数存在 **定义时上下文** 和 **运行时上下文** 以及 **上下文是可以改变的** 这样的概念

- `call` 和 `apply` 都是为了改变某个函数运行时的 `context` 即上下文而存在的，换句话说，就是为了改变函数体内部 `this 的指向

- ``call` 和 `apply` 是 `Function` 的方法，他的第一个参数是 `this`，第二个是 `Function` 的参数。比如你的方法里写了 `this`,普通调用这个方法这个 `this` 可能是 `window`

- `其中 `this` 是你想指定的上下文，他可以任何一个 JavaScript 对象(JavaScript 中一切皆对象)

## 004：Jquery 选择器实例

语法|	描述
--|--
$(this)|	当前 HTML 元素
$("p")|	所有 `<p>` 元素
$("p.intro")|	所有 `class="intro"` 的 `<p>` 元素
$(".intro")|	所有 `class="intro"` 的元素
$("#intro")|	`id="intro"` 的元素
$("ul li:first")|	每个 `<ul>` 的第一个 `<li>` 元素
$("[href$='.jpg']")|	所有带有以 `".jpg"` 结尾的属性值的 `href` 属性
$("div#intro .head")|	`id="intro"` 的 `<div>` 元素中的所有 `class="head"` 的元素
$('div[id^="test-"]')|  获取所有 id 以 test- 开头的 div 元素

## 005：Console 调试命令

- `console.dir()`：可以显示一个对象所有的属性和方法
- `console.assert()`：用来判断一个表达式或变量是否为真。如果结果为否，则在控制台输出一条相应信息，并且抛出一个异常
- `console.trace()`：用来追踪函数的调用轨迹
- `console.time()` 和 `console.timeEnd()`：用来显示代码的运行时间

```
console.time("time");
for(var i=0;i<1000;i++){
 　for(var j=0;j<1000;j++){}
}
console.timeEnd("time");
```

- `console.profile()`：性能分析（Profiler）就是分析程序各个部分的运行时间，找出瓶颈所在

```
function Foo(){
  for(var i=0;i<10;i++){funcA(1000);}
  funcB(10000);
}
function funcA(count){
  for(var i=0;i<count;i++){}
}
function funcB(count){
  for(var i=0;i<count;i++){}
}
```

假定有一个函数Foo()，里面调用了另外两个函数funcA()和funcB()，其中funcA()调用10次，funcB()调用1次。然后，就可以分析Foo()的运行性能了。

```
console.profile('性能分析器一');
Foo();
console.profileEnd();
```

## 006：parent() & parents() & closest()

```
<ul id="menu" style="width:100px;">
    <li>
        <ul>
            <li>
                <a href="#">Home</a>
            </li>
        </ul>
    </li>
    <li>End</li>
</ul>
```

```
$("#menu a").click(function() {
   $(this).parent("ul").css("background", "yellow");    //0
   $(this).parent("li").parent("ul").css("background", "yellow");   //1
   $(this).parents("ul").css("background", "yellow");   //2
   $(this).closest("ul").css("background", "yellow");   //3
   return false;
});
```

- `parent()`：方法从指定类型的直接父节点开始查找，只返回一个节点
- `parents()`：方法查找方式同 `parent()` 方法类似，不同的一点在于，当它找到第一的父节点时并没有停止查找，而是继续查找，最后返回多个父节点
- `closest()`：它同 `parents()` 很类似，不同点就在于它只返回一个节点

## 007：数组和字典

字典和数组的简化声明方式

```
var array = [1, 2, 3]; // 数组
var array2 = { "Acer": 500, "Dell": 600 }; // 字典

computer_price["Acer"] = 900;
console.log(computer_price["Acer"]);
console.log(computer_price.Acer );
```

循环：通过 `l = list.length` 来缓存数组的长度，虽然 `length` 是数组的一个属性，但是在每次循环中访问它还是有性能开销。

```
var list = [1, 2, 3, 4, 5, ...... 100000000];
for(var i = 0, l = list.length; i < l; i++) {
  console.log(list[i]);
}
```

## 008：undefined & null

- `null` 表示"没有对象"，即该处不应该有值。典型用法是：
1. 作为函数的参数，表示该函数的参数不是对象。
2. 作为对象原型链的终点。

```
Object.getPrototypeOf(Object.prototype)
// null
```

- `undefined` 表示"缺少值"，就是此处应该有一个值，但是还没有定义。典型用法是：
1. 变量被声明了，但没有赋值时，就等于 `undefined`。
2. 调用函数时，应该提供的参数没有提供，该参数等于 `undefined`。
3. 对象没有赋值的属性，该属性的值为 `undefined`。
4. 函数没有返回值时，默认返回 `undefined`。

```
var i;
i // undefined

function f(x){console.log(x)}
f() // undefined

var  o = new Object();
o.p // undefined

var x = f();
x // undefined
```

## 009：Jquery .load() for img
[here](http://stackoverflow.com/questions/126772/how-to-force-a-web-browser-not-to-cache-images)
and
[here](http://css-tricks.com/snippets/jquery/fixing-load-in-ie-for-cached-images/)
and
[here](http://stackoverflow.com/questions/476679/preloading-images-with-jquery?rq=1)

```
timer = setTimeout(function () {
    $.ajax({
    url: '{% url 'thumbnail_create' repo.id %}?path=' + e(cur_path+file_name) + '&size=' + {{THUMBNAIL_DEFAULT_SIZE}}*10,
    cache: false,
    dataType: 'json',
    success: function(data) {
        pre_src = data.thumbnail_src;
        $("<img id='preview' src='' alt='' />").appendTo("body").hide()
            .on('load', function() {
                var img_heigh = this.height;
                $(this).css({
                    'position': 'absolute',
                    'top'     : (p.top+12-img_heigh/2) + 'px',
                    'left'    : (p.left+50) + 'px',
                    'display' : 'none',
                    'border-style': 'solid',
                }).fadeIn("normal");
            /*
            .load()
            can cease to fire for images that already live in the browser's cache
            so we change image's src attribute to append a random parameter
            to insure to browser image NOT from cache.

            and it may be a little safer to set the load event before setting the src
            just in case the image finishes loading before the load event is set
            */
            }).attr("src",pre_src+ "?" + new Date().getTime())
    },
    error: ajaxErrorHandler
    });
}, 500);
```

## 010：Jquery .on()
[here](http://www.w3schools.com/jquery/event_on.asp)

#### Syntax
`$(selector).on(event,childSelector,data,function,map)`

Parameter|Description
--|--
event | Required. Specifies one or more event(s) or namespaces to attach to the selected elements. Multiple event values are separated by space. Must be a valid event
childSelector | Optional. Specifies that the event handler should only be attached to the specified child elements (and not the selector itself, like the deprecated delegate() method).
data | Optional. Specifies additional data to pass along to the function
function | Required. Specifies the function to run when the event occurs
map | Specifies an event map ({event:function, event:function, ...}) containing one or more event to attach to the selected elements, and functions to run when the events occur

> **Note**: Event handlers attached using the on() method will work for both current and FUTURE elements (like a new element created by a script).
>
> **Tip**: To remove event handlers, use the off() method.
>
> **Tip**: To attach an event that only runs once and then removes itself, use the one() method.

#### Examples

- Basic use
```
function handleClick(e) {
  e.preventDefault();
  console.log('item anchor clicked');
}
$('#container').on('click', 'a', handleClick);
```
```
$("table").on("click", "tr", function() {
    var $this = $(this); // cache for efficiency

    if ($this.hasClass('highlight')) { // if the row is currently highlighted
        $this.removeClass('highlight');
    } else {
        $this.addClass('highlight');
    }
});
```
```
$(".demonstrate").on({
	mouseover:function(){
	$(this).addClass("over");
	},
	mouseout:function(){
	$(this).removeClass("over");
	}
},"ul li")
```
```
$(".demonstrate").on("mouseover mouseout","ul li",function(e){
	if(e.type=="mouseover"){
		$(this).addClass("over");
	}else{
		$(this).removeClass("over");
	}
})
```

- Attach multiple event handlers
```
<body>
<p>Move the mouse pointer over this paragraph.</p>
</body>

<style>
.intro
{
font-size:150%;
color:red;
}
</style>

<script>
$(document).ready(function(){
  $("p").on("mouseover mouseout",function(){
    $("p").toggleClass("intro");
  });
});
</script>
```

- Attach multiple event handlers using the map parameter
```
<body>
<p>Click or move the mouse pointer over this paragraph.</p>
</body>

<script>
$(document).ready(function(){
  $("p").on({
    mouseover:function(){$("body").css("background-color","lightgray");},
    mouseout:function(){$("body").css("background-color","lightblue");},
    click:function(){$("body").css("background-color","yellow");}
  });
});
</script>
```

- Attach a custom event on an element
```
<body>
<button>Trigger custom event</button>
<p>Click the button to attach a customized event on this p element.</p>
</body>

<script>
$(document).ready(function(){
  $("p").on("myOwnEvent", function(event, showName){
    $(this).text(showName + "! What a beautiful name!").show();
  });
  $("button").click(function(){
    $("p").trigger("myOwnEvent",["Anja"]);
  });
});
</script>
```

- Pass along data to the function
```
<body>
<p>Click me!</p>
</body>

<script>
function handlerName(event)
{
  alert(event.data.msg);
}
$(document).ready(function(){
  $("p").on("click", {msg: "You just clicked me!"}, handlerName)
});
</script>
```

- Add event handlers for future elements
```
<body>
<div style="background-color:yellow">
<p>This is a paragraph.</p>
<p>Click any p element to make it disappear. Including this one.</p>
<button>Insert a new p element after this button</button>
</div>
</body>

<script>
$(document).ready(function(){
  $("div").on("click","p",function(){
    $(this).slideToggle();
  });
  $("button").click(function(){
    $("<p>This is a new paragraph.</p>").insertAfter("button");
  });
});
</script>
```

- Remove an event handler
```
<body>
<p>Click this paragraph to change its background color.</p>
<p>Click the button below and then click on this paragraph (the click event is removed).</p>
<button>Remove the click event handler</button>
</body>

<script>
$(document).ready(function(){
  $("p").on("click",function(){
    $(this).css("background-color","pink");
  });
  $("button").click(function(){
    $("p").off("click");
  });
});
</script>
```

## 010：Best Practice

#### The Fastest Way to Build a String

Don't always reach for your handy-dandy `for` statement when you need to loop through an array or object. Be creative and find the quickest solution for the job at hand.

Using native methods (like `join()`), regardless of what’s going on behind the abstraction layer, is usually much faster than any non-native alternative.

```
var store = {'lemon': 'yellow', 'cherry': 'red'};
//AVOID
var str = "Lemons are " + store.lemon + ", tomatos are" + store.cherry;
//BETTER
var str = ["Lemons are ", store.lemon, ", tomatos are", store.cherry].join("");
```

Use `[]` Instead of `New Array()`
```
var arr = ['item 1', 'item 2', 'item 3'];
var list = '<ul><li>' + arr.join('</li><li>') + '</li></ul>';
```

#### Declare Variables Outside of the For Statement

[here](http://jsperf.com/browser-diet-cache-array-length/11)

```
var container = document.getElementById('container');
var i = 0,
    len = someArray.length;
for (i; i < len; i++) {
  container.innerHtml += 'my number: ' + i;
}
```

Using `+=` will recreate a string every time, and a re-paint of the DOM in this case (I think). Better to use an array and `.push()` for each iteration, then `.join('')` after the loop to add to the HTML.

```
var container = document.getElementById('container'),
    result = [],
    i = 0,
    len = someArray.length;

for (i; i < len; i++) {
  result.push('my number: ' + i);
}
container.innerHtml = result.join('');
```
much better to use the DOM API than modifying properties like innerHTML

```
var someArray = [1,2,3,4,5];
var container = document.getElementById('container');
for(var i = 0, len = someArray.length; i < len; i++) {
var n = document.createTextNode(i);
container.appendChild(n);
}
```

#### Reduce Globals

Global variables are visible in every scope. They can be changed by any part of your program at any time. Avoiding global variables in early stage will save you a lot of problems when your code base grows up.

```
<script type="text/javascript">
//AVOID
var x = 5; //it's global
window.y = 2; //it's global
//it's global
function multiply(x, y) {
    return x * y;
}
//BETTER
(function () {
    var x = 5, y = 2;
    function multiply(x, y) {
        return x * y;
    }
})();
</script>
```

or

```
var name = 'Jeffrey';
var lastName = 'Way';
function doSomething() {}
console.log(name); // Jeffrey -- or window.name
```

better

```
var DudeNameSpace = {
   name : 'Jeffrey',
   lastName : 'Way',
   doSomething : function() {...}
}
console.log(DudeNameSpace.name); // Jeffrey
```

#### Don't Pass a String to "SetInterval" or "SetTimeOut"

Never pass a string to SetInterval and SetTimeOut. Instead, pass a function name.
```
setInterval(someFunction, 3000);
```

#### Use {} Instead of New Object()

```
var o = new Object();
o.name = 'Jeffrey';
o.lastName = 'Way';
o.someFunction = function() {
   console.log(this.name);
}
```
better

```
var o = {
   name: 'Jeffrey',
   lastName = 'Way',
   someFunction : function() {
      console.log(this.name);
   }
};
```
```
var o = {};
```

#### Always, Always Use Semicolons(;)

```
var someItem = 'some string';
function doSomething() {
  return 'something';
}
```

####  "For in" Statements

When looping through items in an object, you might find that you'll also retrieve method functions as well. In order to work around this, always wrap your code in an if statement which filters the information

```
var store = {'lemon': 8, 'banana': 12, 'orange': 3};
//WRONG
for (var x in store) {
    console.log(x, store[x]);
}
//BETTER
for (var x in store) {
    if (store.hasOwnProperty(x)) {
        console.log(x, store[x]);
    }
}
```

#### Self-Executing Functions & Use "Timer" Feature to Optimize Your Code

```
(function TimeTracker(){
 console.time("MyTimer");
 for(x=5000; x > 0; x--){}
 console.timeEnd("MyTimer");
})();
```

#### AVOID MULTIPLE "VAR" STATEMENTS

Declare `var` only once. You can place your `var` statements everywhere in your program, but it's more readable if your put them at the top of your functions or block scope. Don't forget to declare your variables and functions before use them.

```
//AVOID
var price = 45;
var delivery = 12;
function getTax(sum) {
    var rate1 = 10;
    var rate2 = 20;
    if (sum > 100) {
        var tax = (sum * rate1) / 100;
    } else {
        var tax = (sum * rate2) / 100;
    }
    return tax;
}
var sum = price + delivery;
var tax = getTax(sum);

//BETTER
var sum, tax,
    price = 45,
    delivery = 12;

function getTax(sum) {
    var tax,
        rate1 = 10, rate2 = 20;
    if (sum > 100) {
        tax = (sum * rate1) / 100;
    } else {
        tax = (sum * rate2) / 100;
    }
    return tax;
}

sum = price + delivery;
tax = getTax(sum);
```

#### STOP TOUCHING THE DOM

Accessing the DOM is memory expensive and may slow down your javascript program. So it's always better to cache the references to DOM elements.

```
//AVOID
document.getElementById("test").style.display = 'block';
document.getElementById("test").className = 'my-class';
document.getElementById("test").innerHTML = 'Hello World';
//BETTER
var el = document.getElementById("test");
el.style.display = 'block';
el.className = 'my-class';
el.innerHTML = 'Hello World';
```

## 011：Jquery & event

#### event.target

The `target` property can be the element that registered for the event or a descendant of it. It is often useful to compare `event.target` to `this` in order to determine if the event is being handled due to event bubbling. This property is very useful in event delegation, when events bubble.

```
<ul>
  <li>item 1
    <ul>
      <li>sub item 1-a</li>
      <li>sub item 1-b</li>
    </ul>
  </li>
  <li>item 2
    <ul>
      <li>sub item 2-a</li>
      <li>sub item 2-b</li>
    </ul>
  </li>
</ul>

<script>
function handler( event ) {
  var target = $( event.target );
  if ( target.is( "li" ) ) {
    target.children().toggle();
  }
}
$( "ul" ).click( handler ).find( "ul" ).hide();
</script>
```
```
event.srcElement.id
event.srcElement.tagName
event.srcElement.type
event.srcElement.value
event.srcElement.name
event.srcElement.className
event.srcElement.parentElement.id
event.srcElement.getattribute
```

1. IE下,`event` 对象有 `srcElement` 属性,但是没有 `target` 属性
2. Firefox下,`event` 对象有 `target` 属性,但是没有 `srcElement` 属性.
3. 但他们的作用是相当的，即：firefox 下的 `event.target` = IE 下的 `event.srcElement`
4. 解决方法:使用 `obj = event.srcElement ? event.srcElement : event.target;`

## `&& `and `||`

#### `&&`

`&&` 运算遇到 `false` 就返回。

1.  `a && b` ，如果 `a` 为 `true`，直接返回 `b`，而不管 `b`为 `true` 或者 `false `；
2. 如果 `a` 为 `false` 那么直接返回 `a`；

```
var a = 1 && 2 && 3;//3
var b = 0 && 1 && 2;//0
var c = 1 && 0  && 2;//0
```

> 上面例子中第一个`var a = 1 && 2 && 3`；因为 `1 && 2`，`1` 为真，返回 `2`。`2 && 3`， `2` 为真，返回 `3`。

#### `||`

`||` 运算遇到 `true` 就返回

```
var a = 0 || 1 || 2;//1
var b = 1 || 0 || 3;//1
```

1. `a || b `,如果 `a` 为 `false`，直接返回 `b`，而不管 `b` 为 `true` 或者 `false `；
2. 如果 `a` 为 `true`，直接返回 `a`，而不会继续往下执行；

#### `&&`  优先级高于 `||`

```
var x = a && b || c
```
1. 根据优先级先算 `a && b` ，然后与 `c` 做 `||` 运算；
1. `a` 是 `false` 则肯定返回 `c`；
2. 如果 `b` , `c` 都是 `true` ，那么我们就可以根据 `a` 来决定 `b` 还是 `c` :
    1. 如果 `a` 是 `false` 则返回 `c`；
    2. 如果 `a` 是 `true` 则返回 `b`；

```
var x = a || b && c
```

1. 根据优先级先算 `b && c` ，然后与 `a` 做 `||` 运算；
1. 如果 `a` 是 `true`，则返回 `a`；
2. 如果 `a` 是 `false`，则如果 `b` 是 `false` ，返回 `b`，如果 `b` 是 `true`，返回 `c`；

### 三元运算符 `true ? if_true_value : if_false_value`

### extend an object `$.extend(item, {'is_user_perm': false})`
