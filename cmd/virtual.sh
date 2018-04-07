echo "VirtualHost $VIR_DOMAIN setting..."

echo "******************************************************"
echo "<VirtualHost *:80>" >> $VHOST_CONF
echo "DocumentRoot $VIR_PATH" >> $VHOST_CONF
echo "ServerName $VIR_DOMAIN" >> $VHOST_CONF
echo "<Directory "$VIR_PATH">" >> $VHOST_CONF
echo "Options FollowSymLinks" >> $VHOST_CONF
echo "AllowOverride All" >> $VHOST_CONF
echo "Allow from all" >> $VHOST_CONF
echo "</Directory>" >> $VHOST_CONF
echo "</VirtualHost>" >> $VHOST_CONF
echo "" >> $VHOST_CONF
echo "" >> $VHOST_CONF

echo "******************************************************"
