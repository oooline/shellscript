#!/bin/bash
cd /home
unset LANG
uptime >> check.log
uname -a >> check.log
cat /proc/version  >> check.log
echo zhanghuxinxiyonghu >> check.log
cat /etc/passwd >> check.log
echo zhanghuxinximima >> check.log
cat /etc/shadow >> check.log
echo zhanghuxinxizu >> check.log
cat /etc/group >> check.log
echo kongkoulingyonghu >> check.log
awk -F: '($2 == ""){print $1}' /etc/passwd >> check.log
echo churootzhiwaiUIDwei0zhanghu >> check.log
awk -F: '($3 == 0) { print $1 }' /etc/passwd >> check.log
echo shellweixiugaiyonghu >> check.log
awk -F: '($7 != "/sbin/nologin" ){print $1}' /etc/passwd >> check.log
echo xitongyonghu >> check.log
awk -F: '($2 != "*" && $2 != "!!"){print $1}' /etc/shadow >> check.log

echo koulingcelue >> check.log
cat /etc/login.defs >> check.log

echo fangwenkongzhicelueallow >> check.log
cat /etc/hosts.allow >> check.log

echo fangwenkongzhiceluedeny >> check.log
cat /etc/hosts.deny >> check.log

echo jinchengxinxi >> check.log
ps -ef >> check.log
echo qidongxinxi >> check.log
chkconfig --list >> check.log

echo sshpeizhi >> check.log
cat /etc/ssh/sshd_config >> check.log
echo telnetpeizhi >> check.log
cat /etc/securetty  >> check.log

echo zhongyaowenjianquanxian >> check.log
ls -al /etc/passwd >> check.log
ls -al /etc/shadow >> check.log
ls -al /etc/group >> check.log
ls -al /etc/ >> check.log

echo rizhipeizhi >> check.log
cat /etc/syslog.conf >> check.log
echo rizhimulu >> check.log
ls -al /var/log >> check.log


echo renherendouyouxiequanxiandewenjianjia >> check.log
for PART in `awk '($3 == "ext2" || $3 == "ext3") \
{ print $2 }' /etc/fstab`; do
find $PART -xdev -type d \( -perm -0002 -a ! -perm -1000 \) -print
done >> check.log

echo renherendouyouxiequanxiandewenjian >> check.log
for PART in `grep -v ^# /etc/fstab | awk '($6 != "0") {print $2 }'`; do
find $PART -xdev -type f \( -perm -0002 -a ! -perm -1000 \) -print
done >> check.log

echo umaskpeizhiwenjian >> check.log
echo profile >> check.log
more /etc/profile >> check.log
echo csh.login >> check.log
more /etc/csh.login >> check.log
echo csh.cshrc >> check.log
more /etc/csh.cshrc >> check.log
echo bashrc >> check.log
more /etc/bashrc >> check.log

echo Apachejiancha >> check.log
apachectl -v  >> check.log
php -v >> check.log
ps -ef |grep apache  >> check.log
ps -ef |grep mysql  >> check.log
echo /usr/local/apache2 >> check.log
ls -al /usr/local/apache2 >> check.log
echo /usr/local/apache2/logs >> check.log
ls -al /usr/local/apache2/logs >> check.log
echo /usr/local/apache2/htdocs  >> check.log
ls -al /usr/local/apache2/htdocs  >> check.log

echo  httpd.confpeizhi >> check.log
cat /usr/local/apache2/conf/httpd.conf  >> check.log

echo mysql.cnfpeizhi >> check.log
cat /etc/my.cnf >> check.log

echo feibiyaodeSUID/SGID >> check.log
find / -type f \( -perm -04000 -o -perm -02000 \) -ls >> check.log

