#!/bin/bash
# **********************************************************************
#
#         Cenotos6.5 64位 升级到php5.6 @phpbin
#
#
# **********************************************************************

echo "Cenotos6.5 64位 升级到php5.6 "
yum remove -y php.x86_64 php-cli.x86_64 php-common.x86_64 php-gd.x86_64 php-ldap.x86_64 php-mbstring.x86_64 php-mcrypt.x86_64 php-mysql.x86_64 php-pdo.x86_64
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
yum install -y php56w.x86_64 php56w-cli.x86_64 php56w-common.x86_64 php56w-gd.x86_64 php56w-ldap.x86_64 php56w-mbstring.x86_64 php56w-mcrypt.x86_64 php56w-mysql.x86_64 php56w-pdo.x86_64
echo "Update php5.6 Success ~~"
/etc/init.d/httpd restart