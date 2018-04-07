echo "Installing httpd ......"
echo "***********************************************************"
/usr/bin/yum -y install httpd
chkconfig --levels 235 httpd on
mkdir -p $WEB_PATH

rm -f /var/www/html/index.html
echo "<h1>AutoEnv Success</h1>" >> /var/www/html/index.html
/etc/init.d/httpd start
echo "***********************************************************"