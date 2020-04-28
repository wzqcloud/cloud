#!/bin/bash
SRC_PATH=/root
SRC_NAME=mysql-5.6.46
INSTALL_PATH=/usr/local/mysql
mkdir -p ${INSTALL_PATH}/data

##安装依赖包
yum -y install gcc gcc++ ncurses-devel openssl-devel openssl cmake mariadb-devel  autoconf perl perl-devel 
if [ $? -ne 0 ];then
	exit 2
fi

##添加mysql用户
useradd -r -M -s /sbin/nologin mysql
cd ${SRC_PATH}
tar xf ${SRC_NAME}.tar.gz
cd ${SRC_NAME}

##编译安装mysql
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DINSTALL_DATADIR=/usr/local/mysql/data \
-DDEFAULT_CHARSET=utf8 \
-DDEFAULT_COLLATION=utf8_general_ci \
-DEXTRA_CHARSETS=all \
-DENABLED_LOCAL_INFILE=1
make && make install
if [ $? -eq 0 ];then
	echo "mysql install successful"
else 
	echo "mysql install fail"
	exit 1
fi
chown -R mysql.mysql ${INSTALL_PATH}
cd ${INSTALL_PATH}

##初始化mysql，配置环境变量
./scripts/mysql_install_db --user=mysql --basedir=${INSTALL_PATH} --datadir=${INSTALL_PATH}/data/
echo 'export PATH=/usr/local/mysql/bin:$PATH' > /etc/profile.d/mysql.sh
source /etc/profile.d/mysql.sh

##配置mysql开机自启动并启动mysql服务
\cp -a ${INSTALL_PATH}/support-files/mysql.server /etc/init.d/mysql
\cp -a ${INSTALL_PATH}/support-files/my-default.cnf /etc/my.cnf
service mysql start
chkconfig --add mysql
