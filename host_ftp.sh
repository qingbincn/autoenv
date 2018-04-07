#!/bin/bash
# **********************************************************************
#
#         Cenotos6.5 64位 LAMP 配置FTP虚拟目录 @phpbin
#
#
# **********************************************************************

echo "Cenotos6.5 64位 LAMP 配置FTP虚拟目录"

source conf.sh

#部署目录和域名
DLY_PRNNAME=$(whiptail --title "$TITLE" --inputbox "Please enter you project name!" 10 60 myftp 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $DLY_PRNNAME

DLY_DOMAIN=$(whiptail --title "$TITLE" --inputbox "Please enter you bind domain!" 10 60 myftp.phpbin.cn 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $DLY_DOMAIN

#默认FTP
FTP_NAME=$(whiptail --title "$TITLE" --inputbox "Please enter you ftp username!" 10 60 myftp 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $FTP_NAME

FTP_PWD=$(whiptail --title "$TITLE" --inputbox "Please enter you ftp password!" 10 60 123456 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $FTP_PWD

#虚拟参数
VIR_DOMAIN=$DLY_DOMAIN
VIR_PATH=$WEB_PATH/$DLY_PRNNAME
VHOST_CONF=$HTTPD_VHOST/$DLY_DOMAIN.conf

echo "Crate FTP Path&User"
echo "***********************************************************"
useradd $FTP_NAME -r -m -d $VIR_PATH -s /sbin/nologin
echo $FTP_PWD | passwd --stdin $FTP_NAME
echo $FTP_NAME >> /etc/vsftpd/chroot_list
chmod -R 777 $VIR_PATH
echo "AutoEnv FTP $VIR_DOMAIN" >> $VIR_PATH/index.php
echo ""
echo "Create Virtual Host ......"
source ./cmd/virtual.sh
/etc/init.d/httpd restart
/etc/init.d/vsftpd restart
echo "*********************** Success ****************************"