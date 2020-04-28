include:
  - modules.redis.redis-install

redis-master-config:
  file.managed:
    - name: /etc/redis.conf
    - source: salt://redis-cluster/files/redis-master.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      REDIS_MEM: 100M

redis-master-service:
  service.running:
    - name: redis
    - enable: True
    - watch:
      - file: redis-master-config
