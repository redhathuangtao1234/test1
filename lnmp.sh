#!/bin/bash
tar -xf lnmp_soft.tar.gz
cd /root/lnmp_soft/
tar -xf nginx-1.12.2.tar.gz
cd  nginx-1.12.2
useradd -s /sbin/nologin nginx 
yum -y install gcc openssl-devel pcre-devel
./configure   --prefix=/usr/local/nginx  --user=nginx --group=nginx --with-http_ssl_module
echo "正在编译安装,请稍后"
make &>/dev/null
make install &>/dev/null
echo "开始安装mariadb,php"
yum -y install mariadb mariadb-server mariadb-devel  php php-mysql
cd /root/lnmp_soft/
yum -y install php-fpm-5.4.16-42.el7.x86_64.rpm
sed -i '65,68s/#//' /usr/local/nginx/conf/nginx.conf
sed -i '70,71s/#//' /usr/local/nginx/conf/nginx.conf 
sed -i '70s/fastcgi_params/fastcgi.conf/'  /usr/local/nginx/conf/nginx.conf
echo "开始启动所有服务"
ln -s /usr/local/nginx/sbin/nginx   /usr/sbin
systemctl start php-fpm
systemctl start mariadb

