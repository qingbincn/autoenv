echo "Installing setting ......"
echo "***********************************************************"
ALL_IP_ADD=$(/sbin/ifconfig | awk '{if ( $1 == "inet" && $3 ~ /^Bcast/) print $2}' | cut -f2 -d ":")
ALL_IP_ARR=($ALL_IP_ADD);
TITLE="Binyunet Automatic setup program"

# 安装提醒
if ( ! whiptail --title "$TITLE" --yesno "Setup will empty the data in your server." 10 60) then
    exit
fi

# 清理配置文件
rm -f conf.sh
echo '#conf files' >> conf.sh
chmod -R 777 conf.sh


# 服务器IP
WEB_IP=$(whiptail --title "$TITLE" --inputbox "Please enter you public IP adderss!" 10 60 ${ALL_IP_ARR[1]} 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $WEB_IP
echo "WEB_IP=$WEB_IP" >> conf.sh

# WEB主目录
WEB_PATH=$(whiptail --title "$TITLE" --inputbox "Please enter you deployment path!" 10 60 /mydata/www 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $WEB_PATH
echo "WEB_PATH=$WEB_PATH" >> conf.sh

# MYSQL配置
SQL_PATH=$(whiptail --title "$TITLE" --inputbox "Please enter you mysql data path!" 10 60 /mydata/lib/mysql 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $SQL_PATH
echo "SQL_PATH=$SQL_PATH" >> conf.sh

SQL_PWD=$(whiptail --title "$TITLE" --inputbox "Please enter you mysql default password !" 10 60 123456 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $SQL_PWD
echo "SQL_PWD=$SQL_PWD" >> conf.sh


# SVN 地址
SVN_PATH=$(whiptail --title "$TITLE" --inputbox "Please enter svn repository!" 10 60 /mydata/svn 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $SVN_PATH
echo "SVN_PATH=$SVN_PATH" >> conf.sh


# SVN 默认账号
SVN_NAME=$(whiptail --title "$TITLE" --inputbox "Please enter svn default username !" 10 60 autodeploy 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $SVN_NAME
echo "SVN_NAME=$SVN_NAME" >> conf.sh

SVN_PWD=$(whiptail --title "$TITLE" --inputbox "Please enter svn default password !" 10 60 123456 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $SVN_PWD
echo "SVN_PWD=$SVN_PWD" >> conf.sh

# GIT 地址
GIT_PATH=$(whiptail --title "$TITLE" --inputbox "Please enter git repository!" 10 60 /mydata/repository 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $GIT_PATH
echo "GIT_PATH=$GIT_PATH" >> conf.sh

# http_conf
echo "HTTPD_VHOST=/etc/httpd/conf/vhost" >> conf.sh
echo "HTTPD_CONF=/etc/httpd/conf/httpd.conf" >> conf.sh
echo "SAMBA_CONF=/etc/samba/smb.conf" >> conf.sh
echo "***********************************************************"