# Backbone

## Events

#### object.on(event, callback, [context])

给某一对象绑定回调函数，事件被触发时，会执行回调函数。

如果一个页面中有大量不同的事件，可使用冒号 `:`，赋予每一事件 `event` 不同的命名空间。
```
book.on({
  "change:title": titleView.update,
  "change:author": authorPane.update,
  "destroy": bookView.remove
});
```
> All Backbone event methods also support an event map syntax, as an alternative to positional arguments

或者使用空格区分的形式也可以：
```
book.on("change:title change:author", ...);
```

调用回调函数是，可指定上下文 `this`:
```
model.on('change', this.render, this)
```

如果绑定的事件名称为 `"all"`，则任何事件发生时，回调函数都会执行。此时，回调函数的第一个参数，为事件名称。For example, to proxy all events from one object to another:
```
proxy.on("all", function(eventName) {
  object.trigger(eventName);
});
```

## Model

#### model.set(attributes, [options])

给 `model` 的属性赋值，如果任何属性更改了 `model` 的状态，`model` 的 `"change"` 事件会被触发。

通过 `change:title` 和 `change:content`，可以为某一特定属性绑定 `"change"` 事件，若在 `set` 时，此属性有更改，相应 `"change"` 事件也会被触发。

```
note.set({title: "March 20", content: "In his eyes she eclipses..."});
book.set("title", "A Scandal in Bohemia");
```

#### model.save([attributes], [options])

1. 通过绑定 `Backbone.sync`，将 `model` 存储到数据库，若成功则返回 `jqXHR`，若失败返回 `false`；

2. `attributes` 是你想更改的键值。`model` 中定义，`attributes` 中没有的键值，将保持不变，但是会一同发给服务器。
        > 可以通过 `model.save(attrs, {patch: true})` 选项，只将有更改的数据发送给服务器，这时会发送 `HTTP PATCH` 请求。

3. `set` 中也接受同样的键值对参数 `attributes`。`save` 和 `set` 接受参数形式，以下两种都可以：
    - `book.set("title", "A Scandal in Bohemia");`
    - `note.set({title: "March 20", content: "In his eyes she eclipses..."});`

4. 如果 `model` 中定义了 `validate` 函数，在 `save` 前会进行数据验证，不通过的话就不会 `save` 操作。

5. 如果服务器中没有这条记录（`model`），即 `model.isNew()`，则发送 `POST` 请求 `create` 数据；否则发送 `PUT` 请求 `update` 数据。
    - `.isNew()`，通过 `model` 中是否存在 `id` 来判断。
    - 通过重写 `sync` 方法，来查看两次 `save` 发送的不同 `HTTP` 请求。

        ```
        Backbone.sync = function(method, model) {
          alert(method + ": " + JSON.stringify(model));
          model.set('id', 1);
        };
        var book = new Backbone.Model({
          title: "The Rough Riders",
          author: "Theodore Roosevelt"
        });
        book.save();
        book.save({author: "Teddy"});
        ```

6. 使用 `save` 会触发以下事件：
    - 立刻触发 `"change"` 事件；
    - 当发送 `ajax` 请求给服务器时，会触发 `"request"` 事件；
    - 服务器返回 `save` 生效后，会触发 `"sync"` 事件；
    - 可以通过 `model.save(attrs, {wait: true})` 选项，使在服务器返回成功后，才将参数数据应用到 `model` 上。

7. `save` 可以在 `[options]` 中定义 `success` 或者 `error` 的回调函数。回调函数接受 `(model, response, options)` 参数。如果服务器端验证失败，需返回一个非 `200` 的状态码，和一个 `text` 或者 `json` 格式的错误信息。

    ```
    book.save("author", "F.D.R.", {error: function(){ ... }});
    ```

#### model.destroy([options])

Destroys the model on the server by delegating an HTTP DELETE request to Backbone.sync.

Returns a jqXHR object, or false if the model isNew. Accepts success and error callbacks in the options hash, which will be passed (model, response, options). Triggers a "destroy" event on the model, which will bubble up through any collections that contain it, a "request" event as it begins the Ajax request to the server, and a "sync" event, after the server has successfully acknowledged the model's deletion. Pass {wait: true} if you'd like to wait for the server to respond before removing the model from the collection.

```
book.destroy({success: function(model, response) {
  ...
}});
```

## Collection

#### collection.where(attributes)

可以实现查找，返回一个 `array`，包含所有匹配的 `model`

```
var friends = new Backbone.Collection([
  {name: "Athos",      job: "Musketeer"},
  {name: "Porthos",    job: "Musketeer"},
  {name: "Aramis",     job: "Musketeer"},
  {name: "d'Artagnan", job: "Guard"},
]);
var musketeers = friends.where({job: "Musketeer"});
alert(musketeers.length);
```

> `collection.findWhere(attributes)`
> 只返回匹配的第一个 `model`。

#### collection.each()

`this.collection.each(this.addOne, this);`

使用了 `underscore.js` 中的 `_.each(list, iteratee, [context])`

遍历（iterate over）一元素列表，按顺序 yield 每一个元素给 `iteratee` 函数，也可将 `iteratee` 函数和一上下文对象（`this`）绑定。

`iteratee` 函数接收三个参数 `(element, index, list)`，If list is a JavaScript object, iteratee's arguments will be (value, key, list). Returns the list for chaining.
```
_.each([1, 2, 3], alert);
=> alerts each number in turn...
_.each({one: 1, two: 2, three: 3}, alert);
=> alerts each number value in turn...
```

#### addcollection.add(models, [options])

在 `collection` 中增加一 `model`（或一个 `model` array），`"add"` 事件将被触发。

If a model property is defined, you may also pass raw attributes objects, and have them be vivified as instances of the model. Returns the added (or preexisting, if duplicate) models.

通过传递 `{at: index}` 可选参数，可以将要增加的 `model` splice 到 `collection` 的指定索引处。

如果 `collection` 中已有要增加的 `model`， 此 `model` 将被忽略不被增加。但若传递了 `{merge: true}` 参数， 新 `model` 中的属性值，将被合并到相应 `model` 中，同时触发任何可能的 `change` 事件。

```
var ships = new Backbone.Collection;
ships.on("add", function(ship) {
  alert("Ahoy " + ship.get("name") + "!");
});

ships.add([
  {name: "Flying Dutchman"},
  {name: "Black Pearl"}
]);
```

> Note that adding the same model (a model with the same id) to a collection more than once
is a no-op.

#### collection.fetch([options])

从服务器中获取 `models`，并将他们 `set` 给 `collection`。当从服务器中得到 `model` 的数据后，会自动通过 `set` 将数据合并。但如果在可选参数中设置了 `{reset: true}`，`collection` 会被 `reset`，

```
Backbone.sync = function(method, model) {
  alert(method + ": " + model.url);
};
var accounts = new Backbone.Collection;
accounts.url = '/accounts';
accounts.fetch();
```

The behavior of fetch can be customized by using the available `set` options. For example, to fetch a collection, getting an `"add"` event for every new model, and a `"change"` event for every changed existing model, without removing anything: `collection.fetch({remove: false})`

### collection.set(models, [options])

用作为参数的 `models`，更新 `collection` 中已经有的 `model`，并返回更新后 `collection` 中的 `models`：
1. 如果某个被 `set` 的 `model`，不在 `collection` 中，则 `add`，此时 `"add"` 事件会被触发；
2. 如果已存在，则会合并相应属性值，此时 `"change"` 事件会被触发；
3. 如果 `collection` 中有，但是参数中没有的 `model`，会被删除，此时 `"remove"` 事件会被触发；

可以通过选项 `{add: false}, {remove: false}, or {merge: false}`，禁止事件被触

```
var vanHalen = new Backbone.Collection([eddie, alex, stone, roth]);
vanHalen.set([eddie, alex, stone, hagar]);
// Fires a "remove" event for roth, and an "add" event for "hagar".
// Updates any of stone, alex, and eddie's attributes that may have
// changed over the years.
```

#### collection.create(attributes, [options])

在 `collection` 中创建新 `model` 实例的简便方法，返回值为新创建的 `model`，等同于：

1. 通过键值对属性实例化一个 `model`；
2. 将 `model` 保存到服务器；
3. 创建成功后，将此 `model` 加入到 `collection` 中。

如果客户端处验证失败，则此 `model` 不会被保存。因此，需要正确设置相应 `model` 的属性值。

**create** 函数，可以接收键值对属性值、或者一个已经存在但尚未保存的 `model` 为参数。

会立刻触发 `collection` 的 `"add"` 事件。

Creating a model will cause an immediate "add" event to be triggered on the collection, a "request" event as the new model is sent to the server, as well as a "sync" event, once the server has responded with the successful creation of the model. Pass {wait: true} if you'd like to wait for the server before adding the new model to the collection.

```
var Library = Backbone.Collection.extend({
  model: Book
});
var nypl = new Library;
var othello = nypl.create({
  title: "Othello",
  author: "William Shakespeare"
});
```

#### collection.comparator
#### collection.sort([options])
####

# Underscore.js

## Collection

#### _.invoke(list, methodName, *arguments)

调用 `methodName` 函数，处理 `list` 中的每一个值。Any extra arguments passed to invoke will be forwarded on to the method invocation.

```
_.invoke([[5, 1, 7], [3, 2, 1]], 'sort');
=> [[1, 5, 7], [1, 2, 3]]
```

## template

```
this.$topNavGrp.after(this.template({groups: this.groups.toJSON()}));
```
```
<% for (var i = 0; i < groups.length; i++) { %>
<li class="item" data-url="<%= app.config.siteRoot %>/group/<%= groups[i].id %>/" title="test"></li>
<% } %>
```
```
 <% _.each(groups, function(group){ %>
     <li class="item" data-url="<%= app.config.siteRoot %>/group/<%= group.id %>/" title="test"></li>
 <% }); %>
```
