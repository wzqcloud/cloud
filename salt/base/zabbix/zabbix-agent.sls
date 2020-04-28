include:
  - init.yum-repo

zabbix-agent:
  pkg.installed:
    - name: zabbix22-agent
    - require: 
      - file: /etc/yum.repos.d/epel-7.repo
  file.managed:
    - name: /etc/zabbix_agentd.conf
    - source: salt://zabbix/files/zabbix_agentd.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      ZABBIX_SERVER: 192.168.56.11
      AGENT_HOSTNAME: {{ grains['fqdn'] }}
    - require:
      - pkg: zabbix-agent
  service.running:
    - name: zabbix-agent
    - enable: True
    - watch:
      - file: zabbix-agent
      - pkg: zabbix-agent

zabbix_agentd.conf.d:
  file.directory:
    - name: /etc/zabbix_agentd.conf.d
    - watch_in:
      - service: zabbix-agent
    - require:
      - pkg: zabbix-agent
      - file: zabbix-agent
