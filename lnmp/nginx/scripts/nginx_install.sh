##定义变量
#!/bin/bash
SRC_PATH=/root/
INSTALL_PATH=/usr/local/nginx
nginx=${INSTALL_PATH}/sbin/nginx

##安装依赖包
yum -y install pcre-devel openssl openssl-devel gd-devel gcc gcc-c++
if [ $? -ne 0 ];then
        exit 2
fi

##创建nginx用户及日志目录
useradd -r -M -s /sbin/nologin nginx
mkdir -p ${INSTALL_PATH}/log
chown -R nginx.nginx ${INSTALL_PATH}/log

##安装工具包
yum -y groups mark install 'Development Tools'
cd ${SRC_PATH}
tar xf nginx-1.16.1.tar.gz
cd nginx-1.16.1

##编译nginx
./configure \
--prefix=${INSTALL_PATH} \
--user=nginx \
--group=nginx \
--with-debug \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_image_filter_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_stub_status_module \
--http-log-path=${INSTALL_PATH}/log/access.log \
--error-log-path=${INSTALL_PATH}/log/error.log
make && make install
if [ $? -eq 0 ];then
        echo "nginx install successful"
else
        echo "nginx install fail"
	exit 3
fi

##nginx编辑脚本实现使用service命令来控制其服务，并设置开机自启
cd -
mv nginx /etc/init.d/
chmod +x /etc/init.d/nginx
chkconfig --add nginx


##添加环境变量，启动nginx
echo "export PATH=${INSTALL_PATH}/sbin:$PATH" > /etc/profile.d/nginx.sh
service nginx start

