echo "Installing vsftpd ......"
echo "***********************************************************"
/usr/bin/yum -y install vsftpd 
/etc/init.d/vsftpd start 
chkconfig --level 3 vsftpd on
sed -i "s/anonymous_enable=YES/anonymous_enable=NO/g" /etc/vsftpd/vsftpd.conf
sed -i "s/#chroot_list_enable/chroot_list_enable/g" /etc/vsftpd/vsftpd.conf
sed -i "s/#chroot_list_file/chroot_list_file/g" /etc/vsftpd/vsftpd.conf
touch /etc/vsftpd/chroot_list
/usr/bin/cut -d : -f  1 /etc/passwd >> /etc/vsftpd/chroot_list
echo "***********************************************************"
