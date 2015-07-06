#!/bin/bash

. setenv.sh

pkill ccnet-server
sleep 0.5

pkill seaf-server
sleep 0.5

ccnet-server -c /home/lian/dev/seafile/tests/basic/conf2 -D all >/tmp/ccnet.log 2>&1 &
sleep 0.5

seaf-server -c /home/lian/dev/seafile/tests/basic/conf2 -d /home/lian/dev/seafile/tests/basic/conf2/seafile-data -D all >/tmp/seafile.log 2>&1 &
sleep 0.5

./manage.py runserver 192.168.1.124:8000
