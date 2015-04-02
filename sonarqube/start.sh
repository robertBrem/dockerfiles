#!/bin/bash

directory="/var/lib/mysql"
if [ ! "$(ls -A $directory)" ]; then
    /usr/bin/mysql_install_db
fi

service mysql start
mysql -u root < /tmp/create_database.sql

/opt/sonar/bin/linux-x86-64/sonar.sh console
