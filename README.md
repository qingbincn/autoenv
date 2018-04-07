##Cenotos6.5 64位 LAMP 自动配置脚本 @phpbin
该脚仅支持Centos6.x版本，使用时请注意自己的服务器版本.  
如果需要使用PHP5.6, 请参考根目录：/php56.txt
###1.脚本初始化安装
将脚本上传到服务器，并设置可执行权限；在服务器根目录新建 /mydata 目录 # yum -y update 对服务器版本进行更新  
本教程将脚本上传到 /root 目录进行演示。 
  
`$ yum -y update`    
`$ chmod -R 777 **`  
 
![图片001](http://www.phpbin.cn/wp-content/uploads/2018/04/001.jpg "图片001")  
  
`$ ./install.sh`  
  
![图片002](http://www.phpbin.cn/wp-content/uploads/2018/04/002.jpg "图片002")  
![图片003](http://www.phpbin.cn/wp-content/uploads/2018/04/003.jpg "图片003")  
输入服务器的公网IP（阿里云服务器可以自动获取）  
![图片004](http://www.phpbin.cn/wp-content/uploads/2018/04/004.jpg "图片004")  
输入网站部署的目录  
![图片005](http://www.phpbin.cn/wp-content/uploads/2018/04/005.jpg "图片005")  
输入MySQL数据目录  
![图片006](http://www.phpbin.cn/wp-content/uploads/2018/04/006.jpg "图片006")  
输入MySQL初始化密码  
![图片007](http://www.phpbin.cn/wp-content/uploads/2018/04/007.jpg "图片007")  
输入SVN仓库目录  
![图片008](http://www.phpbin.cn/wp-content/uploads/2018/04/008.jpg "图片008")   
输入SVN自动部署账号   
![图片010](http://www.phpbin.cn/wp-content/uploads/2018/04/010.jpg "图片010")  
输入SVN自动部署密码  
![图片011](http://www.phpbin.cn/wp-content/uploads/2018/04/011.jpg "图片011")  
GIT仓库目录  
![图片012](http://www.phpbin.cn/wp-content/uploads/2018/04/012.jpg "图片012")  
慢长行等待初始化完毕  
![图片013](http://www.phpbin.cn/wp-content/uploads/2018/04/013.jpg "图片013")  
打开 http://118.25.100.31/ 测试初始化完成  
![图片009](http://www.phpbin.cn/wp-content/uploads/2018/04/009.jpg "图片009") 
  
###2.安装PHPMyAdmin

`$  ./host_pma.sh`   

![图片014](http://www.phpbin.cn/wp-content/uploads/2018/04/014.jpg "图片014")  
![图片015](http://www.phpbin.cn/wp-content/uploads/2018/04/015.jpg "图片015")  
打开：http://118.25.100.31/phpmyadmin/ 查看安装完成  
![图片016](http://www.phpbin.cn/wp-content/uploads/2018/04/016.jpg "图片016")  
  
###3.使用SVN部署
自动生成SVN项目，Commit后将代码提交到仓库后，自动部署到网站目录  
  
`$  ./host_svn.sh`
  
![图片017](http://www.phpbin.cn/wp-content/uploads/2018/04/017.jpg "图片017")  
输入项目名称，用户生成仓库的名称, 演示用: mysvn   
![图片018](http://www.phpbin.cn/wp-content/uploads/2018/04/018.jpg "图片018")  
输入要绑定的域名, 演示用：mysvn.phpbin.cn  
![图片019](http://www.phpbin.cn/wp-content/uploads/2018/04/019.jpg "图片019")  
输入该项目的SVN账号 , 演示用: mysvn  
![图片020](http://www.phpbin.cn/wp-content/uploads/2018/04/020.jpg "图片020")  
输入该项目SVN密码, 演示用: 123456  
![图片021](http://www.phpbin.cn/wp-content/uploads/2018/04/021.jpg "图片021")  
SVN项目部署完成  
![图片022](http://www.phpbin.cn/wp-content/uploads/2018/04/022.jpg "图片022")  
  
查看地址： http://mysvn.phpbin.cn 能打开说明配置成功  
  
`SVN地址：SVN://118.25.100.31/mysvn 账号：mysvn 密码：123456`
  
###4.使用GIT部署
自动生成GIT项目，Commit后将代码提交到仓库后，自动部署到网站目录  
  
`$  ./host_git.sh`
   
![图片023](http://www.phpbin.cn/wp-content/uploads/2018/04/023.jpg "图片023")  
输入项目名称，用户生成仓库的名称, 演示用: mygit  
![图片024](http://www.phpbin.cn/wp-content/uploads/2018/04/024.jpg "图片024")  
输入要绑定的域名, 演示用：mygit.phpbin.cn  
![图片025](http://www.phpbin.cn/wp-content/uploads/2018/04/025.jpg "图片025")  
输入该项目的GIT账号 , 演示用: mygit  
![图片026](http://www.phpbin.cn/wp-content/uploads/2018/04/026.jpg "图片026")  
输入该项目GIT密码, 演示用: 123456  
![图片027](http://www.phpbin.cn/wp-content/uploads/2018/04/027.jpg "图片027")  
GIT项目部署完成  
![图片028](http://www.phpbin.cn/wp-content/uploads/2018/04/028.jpg "图片028")  
  
查看地址： http://mygit.phpbin.cn 能打开说明配置成功  
  
`git clone git@118.25.100.31:/mydata/repository/mygit.git 账号：mygit 密码：123456`  
`git clone ssh://git@118.25.100.31/mydata/repository/mygit.git 账号：mygit 密码：123456`
  
使用Eclipse GIT PUll  
![图片029](http://www.phpbin.cn/wp-content/uploads/2018/04/029.jpg "图片029")   
![图片030](http://www.phpbin.cn/wp-content/uploads/2018/04/030.jpg "图片030")  
  
###5.使用FTP部署
  
`$  ./host_ftp.sh`  
  
![图片031](http://www.phpbin.cn/wp-content/uploads/2018/04/031.jpg "图片031")  
输入项目名称, 演示用: myftp  
![图片032](http://www.phpbin.cn/wp-content/uploads/2018/04/032.jpg "图片032")  
输入要绑定的域名, 演示用：myftp.phpbin.cn  
![图片033](http://www.phpbin.cn/wp-content/uploads/2018/04/033.jpg "图片033")  
输入该项目的FTP账号 , 演示用: myftp  
![图片034](http://www.phpbin.cn/wp-content/uploads/2018/04/034.jpg "图片034")  
输入该项目FTP密码, 演示用: 123456  
![图片035](http://www.phpbin.cn/wp-content/uploads/2018/04/035.jpg "图片035")  
FTP项目部署完成  
![图片036](http://www.phpbin.cn/wp-content/uploads/2018/04/036.jpg "图片036")  
  
查看地址： http://FTP.phpbin.cn 能打开说明配置成功  
  
`FTP地址：118.25.100.31 账号：myftp 密码：123456`  
`ftp://myftp:123456@118.25.100.31`
  

###6.使用Samba部署
  
`$  ./host_smb.sh`  
  
![图片037](http://www.phpbin.cn/wp-content/uploads/2018/04/037.jpg "图片037")  
输入项目名称， 演示用：mysmb  
![图片038](http://www.phpbin.cn/wp-content/uploads/2018/04/038.jpg "图片038")   
输入要绑定的域名, 演示：mysmb.phpbin.cn    
![图片039](http://www.phpbin.cn/wp-content/uploads/2018/04/039.jpg "图片039")  
输入该项目的Samba账号 , 演示用：mysmb  
![图片040](http://www.phpbin.cn/wp-content/uploads/2018/04/040.jpg "图片040")  
输入该项目Samba密码, 演示用: 123456  
![图片041](http://www.phpbin.cn/wp-content/uploads/2018/04/041.jpg "图片041")  
Samba项目部署完成  
![图片042](http://www.phpbin.cn/wp-content/uploads/2018/04/042.jpg "图片042")  
 查看地址： http://mysmb.phpbin.cn 能打开说明配置成功  
   
`\\118.25.100.31 账号：mysmb 密码：123456`  
  
在Windows7搜索框架中输入：\\\\118.25.100.31  
![图片043](http://www.phpbin.cn/wp-content/uploads/2018/04/043.jpg "图片043")  
![图片044](http://www.phpbin.cn/wp-content/uploads/2018/04/044.jpg "图片044")  
![图片045](http://www.phpbin.cn/wp-content/uploads/2018/04/045.jpg "图片045") 

 
###7.全局清理
如果安装失败可以使用 `clean.sh` 清除所有配置，回收初始状态, 所以要慎用  
【如果/mydata 目录没有清除干净，请手动 rm -rf ** 删除干净】    
  
`$  ./clean.sh`    
  
![图片046](http://www.phpbin.cn/wp-content/uploads/2018/04/046.jpg "图片046")  
![图片047](http://www.phpbin.cn/wp-content/uploads/2018/04/047.jpg "图片047") 
![图片048](http://www.phpbin.cn/wp-content/uploads/2018/04/048.jpg "图片048")  