echo "Installing svn & svn_mod ......"
echo "***********************************************************"
/usr/bin/yum -y install httpd httpd-devel subversion mod_dav_svn mod_auth_mysql
mkdir -p $SVN_PATH
svnserve -d -r $SVN_PATH
echo "svnserve -d -r $SVN_PATH" >> /etc/rc.local
echo "***********************************************************"
