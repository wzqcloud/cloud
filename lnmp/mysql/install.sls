#推送mysql源码包
mysql_src:
  file.managed:
    - name: /root/mysql-5.6.46.tar.gz
    - source: salt://lnmp/mysql/src/mysql-5.6.46.tar.gz

#推送mysql编译安装脚本
mysql_scripts:
  file.managed:
    - name: /root/mysql_install.sh
    - source: salt://lnmp/mysql/scripts/mysql_install.sh


#命令minion端执行mysql安装脚本，并添加环境变量
mysql_install:
  cmd.run:
    - name: bash /root/mysql_install.sh && source /etc/profile.d/mysql.sh

