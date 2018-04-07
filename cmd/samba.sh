echo "Installing samba ......"
echo "***********************************************************"
/usr/bin/yum -y install samba samba-common samba-client
/etc/init.d/smb start
chkconfig --level 3 smb on
cp /etc/samba/smb.conf /etc/samba/smb.conf.bak
echo "***********************************************************"
