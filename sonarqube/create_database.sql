# Create SonarQube database and user.
#
# Command: mysql -u root -p < create_database.sql
#

CREATE DATABASE IF NOT EXISTS sonar CHARACTER SET utf8 COLLATE utf8_general_ci;

GRANT ALL ON sonar.* TO 'sonar'@'%' IDENTIFIED BY 'sonar123';
GRANT ALL ON sonar.* TO 'sonar'@'104.167.98.55' IDENTIFIED BY 'sonar123';
GRANT ALL ON sonar.* TO 'sonar'@'localhost' IDENTIFIED BY 'sonar123';
FLUSH PRIVILEGES;