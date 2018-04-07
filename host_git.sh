#!/bin/bash
# **********************************************************************
#
#         Cenotos6.5 64位 LAMP 配置FTP虚拟目录 @phpbin
#
#
# **********************************************************************

echo "Cenotos6.5 64位 LAMP 配置GIT虚拟目录"

source conf.sh

#部署目录和域名
DLY_PRNNAME=$(whiptail --title "$TITLE" --inputbox "Please enter you project name!" 10 60 mygit 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $DLY_PRNNAME

DLY_DOMAIN=$(whiptail --title "$TITLE" --inputbox "Please enter you bind domain!" 10 60 mygit.phpbin.cn 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $DLY_DOMAIN

#默认FTP
GIT_NAME=$(whiptail --title "$TITLE" --inputbox "Please enter you git username!" 10 60 mygit 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $GIT_NAME

GIT_PWD=$(whiptail --title "$TITLE" --inputbox "Please enter you git password!" 10 60 123456 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $GIT_PWD

#虚拟参数
VIR_DOMAIN=$DLY_DOMAIN
VIR_PATH=$WEB_PATH/$DLY_PRNNAME
RES_PATH=$GIT_PATH/$DLY_PRNNAME.git
VHOST_CONF=$HTTPD_VHOST/$DLY_DOMAIN.conf
GIT_POST=$RES_PATH/hooks/post-receive
source ./cmd/virtual.sh

echo "Crate GIT Path&User"
echo "***********************************************************"
useradd $GIT_NAME
echo $GIT_PWD | passwd --stdin $GIT_NAME

/usr/bin/git init --bare $RES_PATH
chown -R $GIT_NAME:$GIT_NAME $RES_PATH

echo "Make deploy Path"
cd $WEB_PATH
/usr/bin/expect <<-EOF
spawn git clone $GIT_NAME@$WEB_IP:$RES_PATH
expect {
"*yes/no" { send "yes\r"; exp_continue }
"*password:" { send "$GIT_PWD\r" }
}
expect eof
EOF

chmod -R 777 $VIR_PATH
chown -R $GIT_NAME:$GIT_NAME $VIR_PATH
echo "AutoEnv By GIT" >> $VIR_PATH/index.php

cd $VIR_PATH
/usr/bin/git add index.php
/usr/bin/git commit -m 'Initialization GIT'
/usr/bin/expect <<-EOF
spawn git push origin master
expect {
"*yes/no" { send "yes\r"; exp_continue }
"*password:" { send "$GIT_PWD\r" }
}
expect eof
EOF
chown -R $GIT_NAME:$GIT_NAME $VIR_PATH

# auto deploy
echo "#!/bin/sh " >> $GIT_POST
echo "DEPLOY_PATH=$VIR_PATH" >> $GIT_POST
echo "unset GIT_DIR" >> $GIT_POST
echo "cd \$DEPLOY_PATH" >> $GIT_POST
echo "passwd='$GIT_PWD'" >> $GIT_POST
echo "/usr/bin/expect <<-EOF" >> $GIT_POST
echo "spawn git pull origin master" >> $GIT_POST
echo "expect {" >> $GIT_POST
echo "\"*yes/no\" { send \"yes\\r\"; exp_continue }" >> $GIT_POST
echo "\"*password:\" { send \"\$passwd\\r\" }" >> $GIT_POST
echo "}" >> $GIT_POST
echo "expect eof" >> $GIT_POST
echo "EOF" >> $GIT_POST
chmod a+x $GIT_POST

/etc/init.d/httpd restart
echo "*********************** Success ****************************"