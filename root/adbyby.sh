#!/bin/sh /etc/rc.common
#rc.local  /root/adbyby.sh start

start() {
    echo "`date "+%Y-%m-%d %H:%M:%S"` starting adbyby..."
    /root/adbyby/adbyby  >> /tmp/log/adbyby.log 2>&1 &
    lsmod |grep ipt_REDIRECT > /dev/null
    if [ "$?" != "0" ]; then
    	insmod /lib/modules/3.3.8/ipt_REDIRECT.ko
    fi
    iptables -t nat -D PREROUTING -p tcp --dport 80 --source  192.168.199.128/25 -j REDIRECT --to-ports 8118  > /dev/null 2>&1
    iptables -t nat -A PREROUTING -p tcp --dport 80 --source  192.168.199.128/25 -j REDIRECT --to-ports 8118
}

stop() {
    echo "`date "+%Y-%m-%d %H:%M:%S"` stoping adbyby..."
    iptables -t nat -D PREROUTING -p tcp --dport 80 --source  192.168.199.128/25 -j REDIRECT --to-ports 8118  
    ps | grep "/root/adbyby/adbyby" | grep -v 'adbyby.sh' | grep -v 'grep' | awk '{print $1}' | xargs kill -9
}

restart() {
    stop
    sleep 1
    start
}
