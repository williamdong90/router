#!/bin/sh
#crontab 
#*/5 * * * * /bin/sh /root/admonitor.sh &

#clean log at every hour
if [ "`date "+%M"`" == "00" ];then
	echo > /tmp/log/adbyby.log 	
fi

#update&reboot at 1  01:30
if [ "`date "+%d"`" == "01" ];then
if [ "`date "+%H"`" == "01" ];then
  if [ "`date "+%M"`" == "30" ];then
	wget -P /tmp/ http://update.adbyby.com/download/7620n.tar.gz
	if [ "$?" = "0" ]; then  
                /root/adbyby.sh stop
                mkdir -p /tmp/adbyby
		tar -zxvf  /tmp/7620n.tar.gz  -C /tmp/adbyby/
                rm -fr /root/adbyby/adbyby
		cp /tmp/adbyby/adbyby /root/adbyby/
		/root/adbyby.sh start
		rm -fr /tmp/7620n.tar.gz
		rm -fr /tmp/adbyby
	else
		rm -fr /tmp/7620n.tar.gz
		/root/adbyby.sh restart
	fi
   fi
fi
fi


#check adbyby process
isfound=$(ps | grep "/root/adbyby/adbyby" | grep -v 'adbyby.sh' | grep -v 'grep')
if [ -z "$isfound" ] 
then
echo "`date "+%Y-%m-%d %H:%M:%S"` restart adbyby" >> /tmp/log/adbyby.log 
/root/adbyby.sh restart
else
iptables -t nat -L |grep 8118 > /dev/null
if [ "$?" != "0" ]; then
	echo "`date "+%Y-%m-%d %H:%M:%S"` restart adbyby" >> /tmp/log/adbyby.log
	/root/adbyby.sh restart
fi
fi
