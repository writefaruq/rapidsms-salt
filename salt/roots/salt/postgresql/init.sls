db-packages:
    pkg.installed:
        - pkgs:
            - postgresql-contrib-9.1
            - postgresql-server-dev-9.1
            - postgresql-client-9.1
            - libpq-dev

postgresql:
    pkg:
        - installed
    service:
        - running
        - enable: True


{% if 'postgres' in pillar %}
{% for name in pillar['postgres'] %}
user-{{ name }}:
    postgres_user.present:
        - name: {{ name }}
        - require:
            - service: postgresql

database-{{ name }}:
    postgres_database.present:
        - name: {{ name}
        - owner: rapidsms
        - template: template0
        - encoding: UTF8
        - require:
            - postgres_user: rapidsms

database-deployproj:
    postgres_database.present:
        - name: deployproj
        - owner: rapidsms
        - template: template0
        - encoding: UTF8
        - require:
            - postgres_user: rapidsms


{% endfor %}
{% endif %}
