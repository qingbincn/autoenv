echo  "Installing phpmyadmin ......"
echo "***********************************************************"

#VirtualHost
cp $HTTPD_CONF $HTTPD_CONF."default"
sed -i "s/#NameVirtualHost/NameVirtualHost/g" $HTTPD_CONF
sed -i "s/DocumentRoot/#DocumentRoot/g" $HTTPD_CONF
sed -i "s/#ServerName www.example.com:80/ServerName $WEB_IP:80/g" $HTTPD_CONF

#Mkdir vhost
mkdir $HTTPD_VHOST
echo "" >> $HTTPD_CONF
echo "" >> $HTTPD_CONF
echo "Include conf/vhost/*.conf" >> $HTTPD_CONF

VHOST_CONF=$HTTPD_VHOST/$WEB_IP.conf
VIR_DOMAIN=$WEB_IP
VIR_PATH=$WEB_PATH
source ./cmd/virtual.sh

#PHPmyadmin
if [ ! -d "$WEB_PATH/phpmyadmin" ]; then
  mkdir -p $WEB_PATH/phpmyadmin
  cd $WEB_PATH
  /usr/bin/wget http://yzcdn.gia114.com/phpmyadmin.zip
  /usr/bin/unzip phpmyadmin.zip
  rm -f phpmyadmin.zip
  chmod -R 755 phpmyadmin
fi

echo "<?php header(\"HTTP/1.1 400 Bad Request\"); ?>" >> $VIR_PATH/index.php
echo "<h1>Bad Request (Invalid Hostname)</h1>" >> $VIR_PATH/index.php
echo "<?php phpinfo();?>" >> $VIR_PATH/phpinfo.php
/etc/init.d/httpd restart
echo "***********************************************************"
