echo "Installing Mysql & Mysqld ......"
echo "***********************************************************"

if [ "$SQL_PATH" != "/var/lib/mysql" ] ; then
echo "Link Mysql data ......"
mkdir -p $SQL_PATH
/etc/init.d/mysqld stop
ln -s $SQL_PATH /var/lib/
fi

/usr/bin/yum -y install mysql mysql-server 
chkconfig --levels 235 mysqld on 
echo "***********************************************************"

/etc/init.d/mysqld start
/usr/bin/mysqladmin -u root password $SQL_PWD
echo "***********************************************************"
