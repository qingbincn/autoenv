"Installing php & php_mod ......"
echo "***********************************************************"
/usr/bin/yum -y install php
/usr/bin/yum -y install php-mysql php-gd php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-curl php-mbstring
chkconfig --levels 235 httpd on
rm -f /var/www/html/phpinfo.php
echo "<?php phpinfo();?>" >> /var/www/html/phpinfo.php
echo "date.timezone = PRC" >> /etc/php.ini
/etc/init.d/httpd restart
echo "***********************************************************"
