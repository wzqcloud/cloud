##推送php源码包
php_src:
  file.managed:
    - name: /root/php-7.2.25.tar.gz
    - source: salt://lnmp/php/src/php-7.2.25.tar.gz


##推送php安装脚本
php_scripts:
  file.managed:
    - name: /root/php_install.sh
    - source: salt://lnmp/php/scripts/php_install.sh


##命令minion端执行php安装脚本，并添加环境变量
php_isntall:
  cmd.run:
    - name: bash /root/php_install.sh && source /etc/profile.d/php.sh
