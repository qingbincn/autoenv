#!/bin/bash
# **********************************************************************
#
#         Cenotos6.5 64位 LAMP 配置SVN-SSL虚拟目录 @phpbin
#
#
# **********************************************************************

echo "Cenotos6.5 64位 LAMP 配置SVN SSL 虚拟目录"

source conf.sh
#部署目录和域名

DLY_PRNNAME=$(whiptail --title "$TITLE" --inputbox "Please enter you project name!" 10 60 mysvn 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $DLY_PRNNAME

DLY_DOMAIN=$(whiptail --title "$TITLE" --inputbox "Please enter you bind domain!" 10 60 mysvn.phpbin.cn 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $DLY_DOMAIN

#用户FTP
USER_NAME=$(whiptail --title "$TITLE" --inputbox "Please enter you svn username!" 10 60 mysvn 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $USER_NAME

USER_PWD=$(whiptail --title "$TITLE" --inputbox "Please enter you svn password!" 10 60 123456 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $USER_PWD

// SLL证书
SSL_CRT=$(whiptail --title "$TITLE" --inputbox "Please enter you ssl CertificateFile!" 10 60 /etc/pki/tls/certs/server.crt 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $SSL_CRT

SSL_KEY=$(whiptail --title "$TITLE" --inputbox "Please enter you ssl CertificateKeyFile!" 10 60 /etc/pki/tls/certs/server.key 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus != 0 ]; then
    exit
fi
echo $SSL_KEY

#虚拟参数
VIR_DOMAIN=$DLY_DOMAIN
VIR_PATH=$WEB_PATH/$DLY_PRNNAME

#SVN参数
SVN_TRUNK=$SVN_PATH/$DLY_PRNNAME
SVN_POST=$SVN_TRUNK/hooks/post-commit
VHOST_CONF=$HTTPD_VHOST/$DLY_DOMAIN.conf
rm -rf $SVN_TRUNK

echo "Crate SVN Path&User"
echo "***********************************************************"
# svn
svnadmin create $SVN_TRUNK
echo $SVN_NAME=$SVN_PWD >> $SVN_TRUNK/conf/passwd

for userstr in ${SVN_USER[@]};do 
echo $userstr >> $SVN_TRUNK/conf/passwd;
done

sed -i "s/# anon-access = read/anon-access=none/g" $SVN_TRUNK/conf/svnserve.conf
sed -i "s/# auth-access = write/auth-access=write/g" $SVN_TRUNK/conf/svnserve.conf
sed -i "s/# password-db = passwd/password-db=passwd/g" $SVN_TRUNK/conf/svnserve.conf

# web
mkdir $VIR_PATH
chmod -R 777 $VIR_PATH
mkdir $VIR_PATH
chmod -R 777 $VIR_PATH
/usr/bin/expect <<-EOF
spawn svn co svn://$WEB_IP/$DLY_PRNNAME $VIR_PATH --username $SVN_NAME --password $SVN_PWD
expect {
"*yes/no" { send "yes\r"; exp_continue }
"*password:" { send "$passwd\r" }
}
expect eof
EOF
chown -R apache:apache $VIR_PATH

# auto deploy
cp $SVN_POST.tmpl $SVN_POST
echo "export LANG=zh_CN.UTF-8" >> $SVN_POST
echo "CURDATE=\`date\`" >> $SVN_POST
echo "SVN=/usr/bin/svn " >> $SVN_POST
echo "WEB=$VIR_PATH" >> $SVN_POST
echo "LOG=$SVN_TRUNK/hooks/codedeploy.log" >> $SVN_POST
echo "echo \"code Deployed By at \$CURDATE\" >> \$LOG " >> $SVN_POST
echo "\$SVN update \$WEB --username $SVN_NAME --password $SVN_PWD >> \$LOG" >> $SVN_POST
echo "echo \"\" >> \$LOG " >> $SVN_POST
#echo "chown -R apache:apache \$VIR_WEB " \>\> $SVN_POST
chmod a+x $SVN_POST

source ./cmd/sslhost.sh
/etc/init.d/httpd restart
echo "*********************** Success ****************************"