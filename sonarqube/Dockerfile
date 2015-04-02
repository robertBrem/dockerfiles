FROM 	dockerfile/java:oracle-java6
MAINTAINER Robert Brem <brem_robert@hotmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://downloads.sourceforge.net/project/sonar-pkg/deb binary/" >> /etc/apt/sources.list
RUN apt-get update && apt-get upgrade -y

#SONAR
RUN apt-get install -y --force-yes sonar

RUN sed -i 's|#wrapper.java.additional.6=-server|wrapper.java.additional.6=-server|g' /opt/sonar/conf/wrapper.conf

RUN sed -i 's|#sonar.jdbc.password=sonar|sonar.jdbc.password=sonar123|g' /opt/sonar/conf/sonar.properties
RUN sed -i 's|sonar.jdbc.url=jdbc:h2|#sonar.jdbc.url=jdbc:h2|g' /opt/sonar/conf/sonar.properties
RUN sed -i 's|#sonar.jdbc.url=jdbc:mysql://localhost|sonar.jdbc.url=jdbc:mysql://localhost|g' /opt/sonar/conf/sonar.properties 


# Install MySQL.
RUN \
  apt-get install -y mysql-server && \
  rm -rf /var/lib/apt/lists/* && \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config && \
  rm -f /tmp/config

# Define working directory.
WORKDIR /data

ADD create_database.sql /tmp/create_database.sql
ADD start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Expose ports.
EXPOSE 3306
EXPOSE 9000 

CMD ["/usr/local/bin/start.sh"]
