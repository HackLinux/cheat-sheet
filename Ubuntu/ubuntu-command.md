# Ubuntu Commands

## head / tail / less

- `head -n ~/solar.html`
show the first **n** lines of the file, **n=10** default

- `tail -n ~/solar.html`
show the last **n** lines of the file, **n=10** default

- `tail -f ~/solar.html`
show the changes of the file ontime

- `less -MN ~/solar.html`

- `tree -L 2 | less -MN`

- 权限范围：
`u` ：目录或者文件的当前的用户
`g` ：目录或者文件的当前的群组
`o` ：除了目录或者文件的当前用户或群组之外的用户或者群组
`a` ：所有的用户及群组

- 权限代号：
`r` ：读权限，用数字4表示
`w` ：写权限，用数字2表示
`x` ：执行权限，用数字1表示

- [more info](http://www.cnblogs.com/peida/archive/2012/11/29/2794010.html)

## chmod

#### 文字设定法

```
chmod [-cfvR] [--help] [--version] mode file
chmod u+x test.sh
```

- Args
`-c` : 若该档案权限确实已经更改，才显示其更改动作
`-f` : 若该档案权限无法被更改也不要显示错误讯息
`-v` : 显示权限变更的详细资料
`-R` : 对目前目录下的所有档案与子目录进行相同的权限变更(即以递回的方式逐个变更)
`–help` : 显示辅助说明
`–version` : 显示版本

- 权限范围：
`u` ：目录或者文件的当前的用户
`g` ：目录或者文件的当前的群组
`o` ：除了目录或者文件的当前用户或群组之外的用户或者群组
`a` ：所有的用户及群组

-  权限操作
`+` 表示增加权限
`-` 表示取消权限
`=` 表示唯一设定权限。

-  权限代号：
`r` ：读权限，用数字4表示
`w` ：写权限，用数字2表示
`x` ：执行权限，用数字1表示

#### 数字设定法

- 所有者有读和写的权限，组用户只有读的权限
`sudo chmod 644 ×××`

- 只有所有者有读和写以及执行的权限
`sudo chmod 700 ×××`

- 每个人都有读和写的权限
`sudo chmod 666 ×××`

- 每个人都有读和写以及执行的权限
`sudo chmod 777 ×××`

> 其中 `×××` 指文件名（也可以是文件夹名，不过要在 `chmod` 后加 `-ld`）。
> 数字文字对应关系: r=4，w=2，x=1
> 若要 `rwx` 属性则 4+2+1=7
> 若要 `rw-` 属性则 4+2=6；
> 若要 `r-x` 属性则 4+1=7。
> 0 [000] 无任何权限
> 4 [100] 只读权限
> 6 [110] 读写权限
> 7 [111] 读写执行权限

## rm

- 语法：
`rm [选项] 文件`

- 说明：
如果没有使用 `-r` 选项，则 `rm` 不会删除目录。

- 各选项含义如下：
`-f`  忽略不存在的文件，从不给出提示。
`-r`  指示 `rm` 将参数中列出的全部目录和子目录均递归地删除。
`-i`  进行交互式删除。

## [grep](http://www.cnblogs.com/end/archive/2012/02/21/2360965.html)

## useradd / passwd

- Without a home directory
`sudo useradd myuser`

- With home directory
`sudo useradd -m myuser`

- Then set the password
`sudo passwd myuser`

- Then set the shell
`sudo usermod -s /bin/bash myuser`

## curl

- 自定义头信息传递给服务器
`-H/--header <line>`

- HTTP POST方式传送数据
`-d/--data <data>`

- 指定什么命令
`-X/--request <command>`

- 详细信息
`-v/--verbose`

- 以get的方式来发送数据
`-G/--get`

- 模拟http表单提交数据
`-F/--form <name=content>`

## mv

`mv` 命令用来为文件或目录改名、或将文件移入其它位置。

- 文件改名
`mv [-if] 源文件 目标文件`

- 将文件(一或多个)移入到指定目录中.
`mv [-if] 文件... 目录`

选项介绍:

- `-i`:
若指定目录已有同名文件，则先询问是否覆盖旧文件;

- `-f`:
在mv操作要覆盖某已有的目标文件时不给任何指示;

执行范例:

- 将text.txt文件改名为text.log
`mv text.txt text.log`

- 将text.log和yesterday.log放入logs目录中
`mv text.log yesterday.log logs`

- 将info目录放入logs目录中。注意，如果logs目录不存在，则该命令将info改名为logs。
`mv info/ logs`

## cp

-  该命令将文件exam1.c拷贝到/usr/wang 这个目录下，并改名为 shiyan1.c。
`cp - i exam1.c /usr/wang/shiyan1.c`

- 若不希望重新命名，可以使用下面的命令：
`cp exam1.c /usr/ wang/`

- 将/usr/xu目录中的所有文件及其子目录拷贝到目录/usr/liu中。
`cp -r /usr/xu/ /usr/liu/`

> 需要说明的是，为防止用户在不经意的情况下用cp命令破坏另一个文件，如用户指定的目标文件名是一个已存在的文件名，用cp命令拷贝文件后，这个文件就会被新拷贝的源文件覆盖，因此，建议用户在使用cp命令拷贝文件时，最好使用i选项。

## find

```
find <指定目录> <指定条件> <指定动作>
find ~/ -type f -name "myapp.log"
```

- <指定目录>： 所要搜索的目录及其所有子目录。默认为当前目录。
- <指定条件>： 所要搜索的文件的特征。
- <指定动作>： 对搜索结果进行特定的处理。

```
find . -name "my*"
find . -name "my*" -ls
find  -name '*.JPG' -exec rename 's/JPG/jpg/'  {} \;
```

- 列出搜索到的文件
`find . -name "shuaige.txt" -exec ls {} \`

- 批量删除搜索到的文件
`find . -name "shuaige.txt" -exec rm -f {} \`

- 删除前有提示
`find . -name "shuaige.txt" -ok rm -rf {} \`

- 删除当前目录下面所有 test 文件夹下面的文件
`find . -name "test" -type d -exec rm -rf {} \`

## ln

当我们需要在不同的目录，用到相同的文件时，我们不需要在每一个需要的目录下都放一个必须相同的文件，我们只要 在某个固定的目录，放上该文件，然后在其它的目录下用ln命令链接（link）它就可以，不必重复的占用磁盘空间。例

```
ln -s 源文件 目标文件
ln -s /bin/less   /usr/local/bin/less
```

`-s` 是代号 **symbolic** 的意思。

1. `ln` 命令会保持每一处链接文件的同步性，也就是说，不论你改动了哪一处，其它的文件都会发生相同的变化；

2. `ln` 的链接又软链接和硬链接两种，软链接就是 `ln -s ** **` ,它只会在你选定的位置上生成一个文件的镜像，不会 占用磁盘空间，硬链接 `ln ** **` ,没有参数 `-s`, 它会在你选定的位置上生成一个和源文件大小相同的文件，无论是软链 接还是硬链接，文件都保持同步变化。

3. 软链接是可以跨分区的，但是硬链接只能在同一分区内。
如果你用 `ls` 察看一个目录时，发现有的文件或文件夹的颜色和别的不一样，我机子上是蓝色的，那就是一个用 `ln` 命令生成的文件，用 `ls -l` 命令去察看 ，就可以看到显示的 **link** 的路径了。

## port

- 扫描端口
```
sudo apt-get install nmap
nmap  localhost/ip/domain name
```

- 查看端口进程
```
sudo lsof -i :port
sudo netstat -nap|grep port
```

- 启动｜停止｜重启端口
```
sudo service apache2 stop(|start|restart)
sudo /etc/init.d/service start|stop|restart
sudo kill PID
```

## change terminal color

add `PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]\u@\h\[\033[00m\]:\[\033[01;36m\]\w\[\033[00m\]\$ '` to `.basrc`

## change file content at terminal

```
cat >> path/to/file/to/append-to.txt << "EOF"
export PATH=$HOME/jdk1.8.0_31/bin:$PATH
export JAVA_HOME=$HOME/jdk1.8.0_31/
EOF
```

## I/O

- 标准输入(`stdin`)
默认为键盘输入

- 标准输出(`stdout`)
默认为屏幕输出，表示为 `1`

- 标准错误输出(`stderr`)
默认也是输出到屏幕，表示为 `2`


- 将输出重定向到 ls_result 文件中
`ls > ls_result`

- 追加到 ls_result 文件中
`ls -l >> ls_result`

- 只有标准输出被存入 all_result 文件中
`find /home -name lost* > all_result`

- 表示将标准错误输出重定向
`find /home -name lost* 2> err_result`

- 不输出错信息
`find /home -name lost* 2> /dev/null`

- 标准错误输出和标准输入一样都被存入到文件中
```
find /home -name lost* > all_result 2>& 1
or
find /home -name lost* >& all_result
```

> 1. `>` 就是输出（标准输出和标准错误输出）重定向的代表符号;
> 2. 连续两个 `>` 符号，即 `>>` 则表示不清除原来的而追加输出;

## df -hl

Filesystem|Size|Used|Avail|Use%|Mountedon
--|--|--|--|--|--
/dev/sda7|92G|6.8G|81G|8%|/
none|4.0K|0|4.0K|0%|/sys/fs/cgroup
udev|1.9G|4.0K|1.9G|1%|/dev
tmpfs|387M|1.2M|386M|1%|/run
none|5.0M|0|5.0M|0%|/run/lock
none|1.9G|22M|1.9G|2%|/run/shm
none|100M|72K|100M|1%|/run/user
/dev/sda6|268M|149M|102M|60%|/boot
/dev/sda8|103G|9.5G|89G|10%|/home

HD硬盘接口的第一个硬盘（a），第二个分区（8），容量是103G，用了9.5G，可用是89，因此利用率是10%， 被挂载到（/home）

## ls -1 /home/lian/dev | wc -l

count how many files there are in the current directory

> that's an `L` rather than a `1` as in the previous examples

- If you want to count only files and NOT include symbolic links

`ls -l | grep -v ^l | wc -l`

> `grep` checks for any line beginning with `l` (indicating a link), and > discards that line (`-v`)

## `uname -m` & `sudo lsb_release -a`

#### 其他

- 查询文件权限的命令
`ls -l filename`

- 查询文件夹权限的命令
`ls -ld filename`

- [more info](http://www.cnblogs.com/peida/archive/2012/11/29/2794010.html)

- [`netstat -anpt | grep 8000`](http://www.cnblogs.com/ggjucheng/archive/2012/01/08/2316661.html)

## MySql

#### common commands

- login mysql
`mysql -u root -p`

- list databases/tables
`show databases;`
`show tables;`

- create database
`create database test;`

- switch database
`use mysql;`

- delete database
`mysqladmin -u root -p drop mytestdb`
`mysqladmin -u root -p drop mytestdb`

- change a user's password
```
mysql -u root -p
mysql> use mysql;
mysql> update user set password=PASSWORD('password') where User='user';
mysql> flush privileges;
mysql> quit
```

#### access to Mysql database from remote server
```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
mysql> FLUSH PRIVILEGES;
```

then open ***my.cnf***

`sudo vi /etc/mysql/my.cnf`

and comment this line out

`bind-address = 127.0.0.1`

#### How do I show the schema of a table in a MySQL database

`show create table table_name`
or
`describe [dbname.]table_name`

#### get a list of MySQL user accounts

`SELECT User FROM mysql.user;`

#### [MySQL Error 1170 (42000): BLOB/TEXT Column Used in Key Specification Without a Key Length](http://stackoverflow.com/questions/1827063/mysql-error-key-specification-without-a-key-length)

#### [图解SQL的Join](http://coolshell.cn/articles/3463.html)

## Nginx

- config file: 'etc/nginx/sites-enabled'
- log file: `/var/log/nginx`

- `sudo service nginx start/restart`

## crontab

- `crontab -e`
To open crontab

- `crontab -l`
To list crontab content

- `crontab -r`
To remove all your cron jobs

```
*    *    *    *    *  command to be executed
┬    ┬    ┬    ┬    ┬
│    │    │    │    │
│    │    │    │    │
│    │    │    │    └───── day of week (0 - 6) (0 is Sunday, or use names)
│    │    │    └────────── month (1 - 12)
│    │    └─────────────── day of month (1 - 31)
│    └──────────────────── hour (0 - 23)
└───────────────────────── min (0 - 59)
```

- `09 05 1 1 1  mycommand`
Run mycommand at 5:09am on January 1st plus every Monday in January

- `05,35 02,08 1-28 1,7 *  mycommand`
Run mycommand at 05 and 35 past the hours of 2:00am and 8:00am on the 1st through the 28th of every January and July.

- `*/5 * * * *  mycommand`
Run mycommand every 5 minutes

ENTRY	               | DESCRIPTION                                | EQUIVALENT TO
-----                  | -----------                                | -------------
@yearly (or @annually) | Run once a year, midnight, Jan. 1st        | 0 0 1 1 *
@monthly               | Run once a month, midnight, first of month	| 0 0 1 * *
@weekly                | Run once a week, midnight on Sunday        | 0 0 * * 0
@daily                 | Run once a day, midnight                   | 0 0 * * *
@hourly                | Run once an hour, beginning of hour        | 0 * * * *
@reboot                | Run at startup                             |
