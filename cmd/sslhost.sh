echo "VirtualHost SSL $VIR_DOMAIN setting..."

echo "******************************************************"
echo "<VirtualHost *:443>" >> $VHOST_CONF
echo "DocumentRoot $VIR_PATH" >> $VHOST_CONF
echo "ServerName $VIR_DOMAIN:443" >> $VHOST_CONF
echo "SSLEngine on" >> $VHOST_CONF
echo "SSLCertificateFile $SSL_CRT" >> $VHOST_CONF
echo "SSLCertificateKeyFile $SSL_KEY" >> $VHOST_CONF
echo "<Directory "$VIR_PATH">" >> $VHOST_CONF
echo "Options FollowSymLinks" >> $VHOST_CONF
echo "AllowOverride All" >> $VHOST_CONF
echo "Allow from all" >> $VHOST_CONF
echo "</Directory>" >> $VHOST_CONF
echo "</VirtualHost>" >> $VHOST_CONF
echo "" >> $VHOST_CONF
echo "" >> $VHOST_CONF

echo "******************************************************"
