#!/bin/bash
# **********************************************************************
#
#         Cenotos6.5 64位 LAMP 配置SAMBA共享目录 @phpbin
#
#
# **********************************************************************

echo "Cenotos6.5 64位 LAMP 配置SAMBA共享目录"

source conf.sh

#部署目录和域名
DLY_PRNNAME=$(whiptail --title "$TITLE" --inputbox "Please enter you project name!" 10 60 mysmb 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $DLY_PRNNAME

DLY_DOMAIN=$(whiptail --title "$TITLE" --inputbox "Please enter you bind domain!" 10 60 mysmb.phpbin.cn 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $DLY_DOMAIN

#默认SMB
SMB_NAME=$(whiptail --title "$TITLE" --inputbox "Please enter you samba username!" 10 60 mysmb 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $SMB_NAME

SMB_PWD=$(whiptail --title "$TITLE" --inputbox "Please enter you samba password!" 10 60 123456 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $SMB_PWD

#虚拟参数
VIR_DOMAIN=$DLY_DOMAIN
VIR_PATH=$WEB_PATH/$DLY_PRNNAME
VHOST_CONF=$HTTPD_VHOST/$DLY_DOMAIN.conf

echo "Crate SMB Path&User"
echo "***********************************************************"
useradd $SMB_NAME -r -m -d $VIR_PATH -s /sbin/nologin
echo $SMB_PWD | passwd --stdin $SMB_NAME
(echo $SMB_PWD; echo $SMB_PWD) | smbpasswd -s -a $SMB_NAME

echo "[$DLY_PRNNAME]" >> $SAMBA_CONF
echo "path=$VIR_PATH" >> $SAMBA_CONF
echo "available = yes" >> $SAMBA_CONF
echo "browseable = yes" >> $SAMBA_CONF
echo "public = yes" >> $SAMBA_CONF
echo "writable = yes" >> $SAMBA_CONF
echo "guest ok = no" >> $SAMBA_CONF
echo "valid users = $SMB_NAME" >> $SAMBA_CONF
echo "" >> $SAMBA_CONF

chmod -R 777 $VIR_PATH
echo "AutoEnv FTP $VIR_DOMAIN" >> $VIR_PATH/index.php
echo ""
echo "Create Virtual Host ......"
source ./cmd/virtual.sh
/etc/init.d/httpd restart
/etc/init.d/smb restart
echo "*********************** Success ****************************"