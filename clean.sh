#!/bin/bash
# **********************************************************************
#
#         Cenotos6.5 64位 LAMP 安装清理 @phpbin
#
#
# **********************************************************************

echo "Cenotos6.5 64位 LAMP 安装清理"

source conf.sh

TITLE="Binyunet Automatic setup program"
if [  -z "$WEB_PATH" ]; then
    whiptail --title "$TITLE" --msgbox "You are not installed, please don't clean" 10 60
    exit
fi

if ( ! whiptail --title "$TITLE" --yesno "Clean will empty the data in your server." 10 60) then
    exit
fi

rm -rf /var/run/yum.pid

# 1.清除Mysql
echo "1. Clearing Mysql & Mysqld ...."
echo "***********************************************************"
/usr/bin/yum -y remove mysql mysql-server
rm -rf /var/lib/mysql
rm -rf $SQL_PATH
echo "***********************************************************"

# 2.清除httpd
echo "2. Clearing httpd ...."
echo "***********************************************************"
/usr/bin/yum -y remove httpd
rm -rf $WEB_PATH/**
rm -rf /etc/httpd
echo "***********************************************************"

# 3.清除php
echo "3. Clearing php & php_mod ...."
echo "***********************************************************"
/usr/bin/yum -y remove php
/usr/bin/yum -y remove php-mysql php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-curl php-mbstring
echo "***********************************************************"

# 4.清除SNV
echo "4. Clearing svn & svn_mod ...."
echo "***********************************************************"
/usr/bin/killall svnserve
/usr/bin/yum -y remove install httpd httpd-devel subversion mod_dav_svn mod_auth_mysql
rm -rf $SVN_PATH
echo "***********************************************************"
/usr/bin/yum -y remove git expect
rm -rf $GIT_PATH
echo "***********************************************************"

# 5.清除svftd
echo "5. Clearing svftd ...."
echo "***********************************************************"
/usr/bin/yum -y remove vsftpd 
rm -rf /etc/vsftpd/
userdel -rf cdn1
echo "***********************************************************"

# 6.清除SSL
echo "6. Clearing SSL ...."
echo "***********************************************************"
/usr/bin/yum -y remove mod_ssl
rm -rf /etc/pki/tls/certs/server*
userdel -r laowu
userdel -rf cdn2
userdel -rf cdn3
echo "***********************************************************"

# 7.清除Samba
echo "7. Clearing smamba ...."
echo "***********************************************************"
/usr/bin/yum -y remove samba samba-common samba-client
rm -rf /etc/samba
echo "***********************************************************"

# 8.清除配置文件
echo "***********************************************************"
echo "7. Clean conif.sh"
rm -f conf.sh
echo '#conf files' >> conf.sh
chmod -R 777 conf.sh
echo "***********************************************************"