#!/bin/bash
# **********************************************************************
#
#         Cenotos6.5 64位 LAMP 自动配置脚本 @phpbin
#
#
# **********************************************************************

echo "Cenotos6.5 64位 LAMP 自动配置脚本"
source conf.sh
source ./cmd/setting.sh
source ./cmd/httpd.sh
source ./cmd/mysql.sh
source ./cmd/php.sh
source ./cmd/svn.sh
source ./cmd/git.sh
source ./cmd/vsftpd.sh
source ./cmd/samba.sh
echo "********** 全部安装完成 *****************"