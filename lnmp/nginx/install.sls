##推送nginx源码包
nginx_src:
  file.managed:
    - name: /root/nginx-1.16.1.tar.gz
    - source: salt://lnmp/nginx/src/nginx-1.16.1.tar.gz

##推送nginx安装脚本1
nginx_scripts1:
 file.managed:
    - name: /root/nginx_install.sh
    - source: salt://lnmp/nginx/scripts/nginx_install.sh

##推送nginx安装脚本2
nginx_scripts2:
  file.managed:
    - name: /root/nginx
    - source: salt://lnmp/nginx/scripts/nginx

##命令minion端执行安装脚本，然后添加环境变量
nginx_install:
  cmd.run:
    - name: bash /root/nginx_install.sh && source /etc/profile.d/nginx.sh


