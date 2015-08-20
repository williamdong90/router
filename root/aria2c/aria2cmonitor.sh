#!/bin/sh
#crontab 
#*/5 * * * * /bin/sh /root/aria2c/aria2cmonitor.sh &

#reboot at 01:40
#if [ "`date "+%H"`" == "01" ];then
#  if [ "`date "+%M"`" == "40" ];then
#  	rm -fr /tmp/log/aria2.log
#   	/root/aria2c/aria2c.sh restart
#   	echo "`date "+%Y-%m-%d %H:%M:%S"` restart aria2c" >> /tmp/log/aria2.log
#   fi
#fi

#check aria2c process
isfound=$(ps | grep "/usr/bin/aria2c" | grep -v 'aria2cmonitor.sh' |grep -v 'grep')
if [ -z "$isfound" ] 
then
echo "`date "+%Y-%m-%d %H:%M:%S"` restart aria2c" >> /tmp/log/aria2.log 
/root/aria2c/aria2c.sh restart
fi
