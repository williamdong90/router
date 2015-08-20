#!/bin/sh
#crontab 
#*/5 * * * * /bin/sh /root/shadowsockstest.sh &

LOGFILE=/root/shadowsockstest.log
touch $LOGFILE
IP=114.114.114.114

if [ "`date "+%H"`" == "01" ];then
  if [ "`date "+%M"`" == "10" ];then
    echo > $LOGFILE
  fi
fi

LOGTIME=$(date "+%Y-%m-%d %H:%M:%S")

isfound=$(ps | grep "ss-local" |grep -v 'grep')
if [ -z "$isfound" ] 
then
  echo '['$LOGTIME'] ss-local died, restarting shadowsocks.' >> $LOGFILE
  /etc/init.d/gw-shadowsocks restart > /dev/null
fi

exit

#wget -4 --spider --quiet --tries=1 --timeout=3 www.google.com
#curl  https://www.google.com -L -k   -m 5 -s  -o /dev/null 
SSTEST=`/overlay/lib/ss-test.lua`
if [ "$SSTEST" == "yes" ]; then
  echo '['$LOGTIME'] Shadowsocks No Problem. ' >> $LOGFILE
else
  wget -4 --spider --quiet --tries=1 --timeout=3 www.baidu.com
  if [ "$?" == "0" ]; then
    echo '['$LOGTIME'] Problem decteted, restarting shadowsocks.' >> $LOGFILE
    /etc/init.d/gw-shadowsocks restart > /dev/null
  else
      if ping -c 3 $IP > /dev/null 
      then
        echo '['$LOGTIME'] DNS Problem. Do nothing.' >> $LOGFILE
      else
        echo '['$LOGTIME'] Network Problem. Do nothing.' >> $LOGFILE 
      fi                                            
  fi
fi

