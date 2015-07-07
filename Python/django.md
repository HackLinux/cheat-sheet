# Django

`pip install Django==1.7.1`

`django.utils.six.moves.urllib` doesnt exist in django==1.5.1 yet. You can try to upgrade django to 1.5.7 for example. Then this import will work.

## Url

- url 定义在这个模块中

`django/conf/urls/defaults`

- 在模版中调用url标签的时候，需要

`{% load url from future %}`

- urls.py

```Python
urlpatterns = patterns('',
    url(r'^article$', 'news_index', name="news_index"),
    url(r'^(?P<year>\d{4})/(?P<month>\d{1,2})/$', 'news_list', name="news_archive" ),
)
```

- Templates

```Python
<a href="{% url 'news_index' %}">Index</a>
<a href="{% url 'news_archive' 2010  02 %}">2010-02</a>
<a href="{% url 'news_archive' year=2010  month=02 %}">2010-02</a>
```

- views.py

```Python
from django.core.urlresolvers import reverse

def news_list(request,year,month):

    print 'year:',year
    print 'monty:',month

    return HttpResponseRedirect(reverse("news_index"))
    return HttpResponseRedirect(reverse("news_archive",kwargs={"year":2010,"month":02}))
```

## Signal

- [什么是signal](https://docs.djangoproject.com/en/dev/ref/signals/)

Django includes a “signal dispatcher” which helps allow decoupled applications get notified when actions occur elsewhere in the framework. In a nutshell, signals allow certain senders to notify a set of receivers that some action has taken place. They’re especially useful when many pieces of code may be interested in the same events.

- 注册signal
```Python
import django.dispatch
user_message_sent = django.dispatch.Signal(providing_args=["msg"])
```

- 发送signal
```Python
def add_unread_message(self, user1, user2, msg):
    ......
    user_message_sent.send(sender=None, msg=new_msg)
    ......
```

- 接收signal
```Python
@receiver(user_message_sent)
def add_user_message_cb(sender, **kwargs):
    ......
```

## Render Templates

#### Context

- 模版中的变量由context中的值来替换
```Python
from django.temlate import loader,Context
t = loader.get_template('xx.html')
c = Context({'user':'zhangsan'})
return HttpResponse(t.render(c))
```
or
```Python
from django.short_cuts import render_to_response
render_to_response('xxx.html',{'user':'zhangsan'})
```

#### RequestContext

Context的一个子类：django.template.RequestContext，在渲染模版的时候就不需要Context，转而使用RequestContext。RequestConntext需要接受request和processors参数，processors是context处理器的列表集合。

默认情况下，Django采用参数TEMPLATE_CONTEXT_PROCESSORS指定默认处理器，意味着只要是调用的RequestContext，那么默认处理器中返回的对象都就将存储在context中。

template_context_processors默认在settings文件中是没有的，而是设置在global_settings.py文件中，如果想加上自己的context处理器，就必须在自己的settings.py中显示的指出参数：TEMPLATE_CONTEXT_PROCESSORS

- settings.py
```Python
TEMPLATE_CONTEXT_PROCESSORS = (
           'django.contrib.auth.context_processors.auth',#django1.4  or after
           'django.core.context_processors.auth',  #django1.4 before
           'django.core.context_processors.debug',
           'django.core.context_processors.i18n',
           'django.core.context_processors.media',
           'myapp.processor.base',
)
```
or
```Python
from django.conf import global_settings
TEMPLATE_CONTEXT_PROCESSORS = global_settings.TEMPLATE_CONTEXT_PROCESSORS +("myapp.processor.foos",)
```

- myapp/processor.py
```Python
def base(request):
    ......
    return {
            'seafile_version': SEAFILE_VERSION,
            'site_title': SITE_TITLE,
           }
```

- views.py
```Python
from django.template import RquestContext
render_to_response('xxx.html',{'age':33},context_instance=(request))
```

## Command

我们都用过Django的django-admin.py和manage.py。django-admin.py是一个命令行工具，可以执行一些管理任务，比如创建Django项目。而manage.py是在创建每个Django project时自动添加在项目目录下的，只是对manage.py的一个简单包装，其功能是将Django project放到sys.path目录中，同时设置DJANGO_SETTINGS_MODULE环境变量为当前project的setting.py文件。

django-admin.py调用django.core.management来执行命令:
```Bash
#!/usr/bin/env python
from django.core import management
if __name__ == "__main__":
   management.execute_from_command_line()
```
excute_from_command_line()函数会根据命令行参数解析出命令的名称，根据命令名称调用相应的Command执行命令。Command位于各个管理模块的commands模块下面。

所谓管理模块，是指在app模块下的名字为management的模块。Django通过django.core.management.find_management_module函数发现"管理模块":

```Python
django.core.management.find_management_module()
def find_management_module(app_name):
    """
    Determines the path to the management module for the given app_name,
    without actually importing the application or the management module.

    Raises ImportError if the management module cannot be found for any reason.
    """
    parts = app_name.split('.')
    parts.append('management')
    parts.reverse()
    part = parts.pop()
    path = None
```

然后通过django.core.management.find_commands函数找到命令类。find_commands函数会在管理模块下查找.py文件，并将.py文件的名称匹配到命令名称:

```Python
def find_commands(management_dir):
    """
    Given a path to a management directory, returns a list of all the command
    names that are available.

    Returns an empty list if no commands are defined.
    """
    command_dir = os.path.join(management_dir, 'commands')
    try:
        return [f[:-3] for f in os.listdir(command_dir)
           if not f.startswith('_') and f.endswith('.py')]
    except OSError:
    return []
```

最后，通过django.core.management.load_command_class函数加载该.py文件中的Command类:

```Python
def load_command_class(app_name, name):
    """
    Given a command name and an application name, returns the Command
    class instance. All errors raised by the import process
    (ImportError, AttributeError) are allowed to propagate.
    """
    module = import_module('%s.management.commands.%s' % (app_name, name))
    return module.Command()
```

在执行命令的时候，会执行相应Command类的handle方法。所有的Command类都应该是django.core.management.base.BaseCommand的直接或间接子类。

原理搞清楚了，扩展manage命令就很容易了。创建一个app并加入到settings的INSTALLED_APPS中，在该app下面创建management.commands模块，并创建hello.py文件:

```Python
from django.core.management.base import BaseCommand, CommandError
from django.db import models

#from placeholders import *

import os

class Command(BaseCommand):
     def handle(self, *args, **options):
         print 'hello, django!'
```

就可以使用hello命令了:

`$ python manage.py hello`

`hello, django!`

## QuerySet

对象关系映射 (ORM) 使得与SQL数据库交互更为简单，不过也被认为效率不高，比原始的SQL要慢。

要有效的使用ORM，意味着需要多少要明白它是如何查询数据库的。本文我将重点介绍如何有效使用 Django ORM系统访问中到大型的数据集。


Django的queryset是惰性的

Django的queryset对应于数据库的若干记录（row），通过可选的查询来过滤。例如，下面的代码会得到数据库中名字为‘Dave’的所有的人:

```
person_set = Person.objects.filter(first_name="Dave")
```
上面的代码并没有运行任何的数据库查询。你可以使用person_set，给它加上一些过滤条件，或者将它传给某个函数，这些操作都不会发送给数据库。这是对的，因为数据库查询是显著影响web应用性能的因素之一。

要真正从数据库获得数据，你需要遍历queryset:
```
for person in person_set:
    print(person.last_name)
```

Django的queryset是具有cache的

当你遍历queryset时，所有匹配的记录会从数据库获取，然后转换成Django的model。这被称为执行（evaluation）。这些model会保存在queryset内置的cache中，这样如果你再次遍历这个queryset，你不需要重复运行通用的查询。

例如，下面的代码只会执行一次数据库查询：
```
pet_set = Pet.objects.filter(species="Dog")
# The query is executed and cached.
for pet in pet_set:
    print(pet.first_name)
# The cache is used for subsequent iteration.
for pet in pet_set:
    print(pet.last_name)
```

if语句会触发queryset的执行

queryset的cache最有用的地方是可以有效的测试queryset是否包含数据，只有有数据时才会去遍历：
```
restaurant_set = Restaurant.objects.filter(cuisine="Indian")
# `if`语句会触发queryset的执行。
if restaurant_set:
    # 遍历时用的是cache中的数据
    for restaurant in restaurant_set:
        print(restaurant.name)
```
如果不需要所有数据，queryset的cache可能会是个问题

有时候，你也许只想知道是否有数据存在，而不需要遍历所有的数据。这种情况，简单的使用if语句进行判断也会完全执行整个queryset并且把数据放入cache，虽然你并不需要这些数据！

```
city_set = City.objects.filter(name="Cambridge")
# `if`语句会执行queryset.。
if city_set:
    # 我们并不需要所有的数据，但是ORM仍然会获取所有记录！
    print("At least one city called Cambridge still stands!")
```
为了避免这个，可以用exists()方法来检查是否有数据：
```
tree_set = Tree.objects.filter(type="deciduous")
# `exists()`的检查可以避免数据放入queryset的cache。
if tree_set.exists():
    # 没有数据从数据库获取，从而节省了带宽和内存
    print("There are still hardwood trees in the world!")
```

当queryset非常巨大时，cache会成为问题

处理成千上万的记录时，将它们一次装入内存是很浪费的。更糟糕的是，巨大的queryset可能会锁住系统进程，让你的程序濒临崩溃。

要避免在遍历数据的同时产生queryset cache，可以使用iterator()方法来获取数据，处理完数据就将其丢弃。

```
star_set = Star.objects.all()
# `iterator()`可以一次只从数据库获取少量数据，这样可以节省内存
for star in star_set.iterator():
    print(star.name)
```
当然，使用iterator()方法来防止生成cache，意味着遍历同一个queryset时会重复执行查询。所以使用iterator()的时候要当心，确保你的代码在操作一个大的queryset时没有重复执行查询。

如果查询集很大的话，if 语句是个问题

如前所述，查询集缓存对于组合 if 语句和 for 语句是很强大的，它允许在一个查询集上进行有条件的循环。然而对于很大的查询集，则不适合使用查询集缓存。

最简单的解决方案是结合使用exists()和iterator(), 通过使用两次数据库查询来避免使用查询集缓存。

```
molecule_set = Molecule.objects.all()
# One database query to test if any rows exist.
if molecule_set.exists():
    # Another database query to start fetching the rows in batches.
    for molecule in molecule_set.iterator():
        print(molecule.velocity)
更复杂点的方案是使用 Python 的“ 高级迭代方法 ”在开始循环前先查看一下 iterator() 的第一个元素再决定是否进行循环。
atom_set = Atom.objects.all()
# One database query to start fetching the rows in batches.
atom_iterator = atom_set.iterator()
# Peek at the first item in the iterator.
try:
    first_atom = next(atom_iterator)
except StopIteration:
    # No rows were found, so do nothing.
    pass
else:
    # At least one row was found, so iterate over
    # all the rows, including the first one.
    from itertools import chain
    for atom in chain([first_atom], atom_set):
        print(atom.mass)
```

防止不当的优化

queryset的cache是用于减少程序对数据库的查询，在通常的使用下会保证只有在需要的时候才会查询数据库。

使用exists()和iterator()方法可以优化程序对内存的使用。不过，由于它们并不会生成queryset cache，可能会造成额外的数据库查询。

所以编码时需要注意一下，如果程序开始变慢，你需要看看代码的瓶颈在哪里，是否会有一些小的优化可以帮到你。


## [use default filesystemstorage](http://runnable.com/UpUJp-2XvjUuAABb/how-to-use-default-filesystemstorage-class-in-django-for-python)


## Django Template Variables to Javascript

```
<script type="text/javascript">
   var a = "{{someDjangoVariable}}"
</script>
```

## Django Translate

```
def my_view(request, m, d):
    # Translators: This message appears on the home page only
    # The comment will then appear in the resulting .po file associated with the translatable contruct located below it and should also be displayed by most translation tools.
    output = _('Today is %(month)s %(day)s.') % {'month': m, 'day': d}
    return HttpResponse(output)
```

## QuerySet: get & filter

Basically use get when you want to get a single unique object, and filter when you want to get all objects that match your lookup parameters.

- get

> Returns the object matching the given lookup parameters, which should be in the format described in Field lookups.
>
> get() raises MultipleObjectsReturned if more than one object was found. The MultipleObjectsReturned exception is an attribute of the model class.
>
> get() raises a DoesNotExist exception if an object wasn't found for the given parameters. This exception is also an attribute of the model class.
>
> `MyTable.objects.get(id=x).whatever` gives you the `whatever` property of your object
>
> if you know it's one object that matches your query, use get. It will fail if it's more than one.

- filter

> Returns a new QuerySet containing objects that match the given lookup parameters.
>
> `MyTable.objects.filter(somecolumn=x)` is not only usable as a list, but you can also query it again, something like `MyTable.objects.filter(somecolumn=x).order_by('date')`.
>
> The reason is that it's not actually a list, but a query object. You can iterate through it like through a list: `for obj in MyTable.objects.filter(somecolumn=x)`



{{ forloop.count }}

request.POST  # Only handles form data.  Only works for 'POST' method.
request.DATA  # Handles arbitrary data.  Works for 'POST', 'PUT' and 'PATCH' methods.
