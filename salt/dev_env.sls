# Install the required packages (Python).
dev_packages:
    pkg.installed:
        - pkgs:
            - python3-dev
            - python-pip

# Install the pip packages.
dev_pip_packages:
    pip.installed:
        - pkgs:
            - virtualenvwrapper

# Setup the project virtual-environment.
/usr/local/virtualenvs:
    file.directory:
        - user: root
        - group: root

# Create the virtual environment.
/usr/local/virtualenvs/env:
    virtualenv.managed:
        - system_site_packages: False
        - python: python3.4

# Setup virtualenvwrapper.
virtualenvwrapper_configuration:
    file.append:
        - name: /home/vagrant/.bashrc
        - test: | +
            WORKON_HOME=/usr/local/virtualenvs
            PROJECT_HOME=/project
            source /usr/local/bin/virtualenvwrapper.sh

# Setup virtualenvwrapper for root.
virtualenvwrapper_root_configuration:
    file.append:
        - name: /root/.bashrc
        - test: | +
            WORKON_HOME=/usr/local/virtualenvs
            PROJECT_HOME=/project
            source /usr/local/bin/virtualenvwrapper.sh

# Install MariaDB Database.
mariadb_repo_installed:
    pkgrepo.managed:
        - humanname: MariaDB10.1 Repository
        - name: deb [arch=amd64,i386] http://lon1.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu trusty main
        - file: /etc/apt/sources.list.d/MariaDB.list
        - keyid: '0xcbcb082a1bb943db'
        - keyserver: keyserver.ubuntu.com
        - refresh_db: True

# Install the MariaDB server using the root password of 'password'.
mariadb_server_installed:
    debconf.set:
        - name: mariadb-server
        - data:
            'mysql-server/root_password': {'type': 'string', 'value': 'password'}
            'mysql-server/root_password_again': {'type': 'string', 'value': 'password'}

# Enable the service so MariaDB starts when the server boots.
mariadb_mysql_service_enabled:
    service.running:
        - name: mysql
        - enable: True
