#!/bin/sh /etc/rc.common
#rc.local  /root/aria2c/aria2c.sh start

start() {
    echo "`date "+%Y-%m-%d %H:%M:%S"` Starting aria2c daemon:"
    /usr/bin/aria2c --conf-path=/root/aria2c/aria2.conf -D
}

stop() {
    echo "`date "+%Y-%m-%d %H:%M:%S"` Shutting down aria2c daemon:"
    /usr/bin/killall aria2c
}

restart() {
    stop
    sleep 1
    start
}
