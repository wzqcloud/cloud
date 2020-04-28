#!/bin/bash
SRC_PATH=/root
SRC_NAME=php-7.2.25
SRC_ZIP=tar.gz

##安装依赖包
yum -y install libxml2 libxml2-devel openssl openssl-devel bzip2 bzip2-devel libcurl libcurl-devel libicu-devel libjpeg libjpeg-devel libpng libpng-devel openldap-devel  libpcre-devel freetype freetype-devel gmp gmp-devel libmcrypt libmcrypt-devel readline readline-devel libxslt libxslt-devel mhash mhash-devel php72w-mysqlnd
if [ $? -ne 0 ];then
	exit 2
fi
cd ${SRC_PATH} 
tar xf ${SRC_NAME}.${SRC_ZIP}
cd ${SRC_NAME}

##编译php
./configure --prefix=/usr/local/php7  \
--with-config-file-path=/etc \
--enable-fpm \
--enable-inline-optimization \
--disable-debug \
--disable-rpath \
--enable-shared \
--enable-soap \
--with-openssl \
--enable-bcmath \
--with-iconv \
--with-bz2 \
--enable-calendar \
--with-curl \
--enable-exif  \
--enable-ftp \
--with-gd \
--with-jpeg-dir \
--with-png-dir \
--with-zlib-dir \
--with-freetype-dir \
--with-gettext \
--enable-json \
--enable-mbstring \
--enable-pdo \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-readline \
--enable-shmop \
--enable-simplexml \
--enable-sockets \
--enable-zip \
--enable-mysqlnd-compression-support \
--with-pear \
--enable-pcntl \
--enable-posix
if [ $? -ne 0 ];then
        exit 3
fi
make && make install
if [ $? -ne 0 ];then
        exit 4
fi

##配置环境变量
echo 'export PATH=/usr/local/php7/bin:$PATH' > /etc/profile.d/php7.sh

##配置php开启自启动和其自身的配置文件
\cp  php.ini-production /etc/php.ini
cp  sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/rc.d/init.d/php-fpm
cp  /usr/local/php7/etc/php-fpm.conf.default /usr/local/php7/etc/php-fpm.conf
cp  /usr/local/php7/etc/php-fpm.d/www.conf.default /usr/local/php7/etc/php-fpm.d/www.conf
cat >> /usr/local/php7/etc/php-fpm.conf <<EOF
pm.max_children = 50
pm.start_servers = 5
pm.min_spare_servers = 2
pm.max_spare_servers = 8
EOF
service php-fpm start
chkconfig --add php-fpm

