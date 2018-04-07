echo "Installing ssl ......"
echo "***********************************************************"
/usr/bin/yum -y install mod_ssl

echo "Create Cert ......"
cd /etc/pki/tls/certs/
make server.key
openssl rsa -in server.key -out server.key
make server.csr
openssl x509 -in server.csr -out server.pem -req -signkey server.key -days 365
openssl x509 -in server.csr -out server.crt -req -signkey server.key -days 365
chmod 400 server.*

echo "NameVirtualHost *:443" >> /etc/httpd/conf/httpd.conf
echo "***********************************************************"
