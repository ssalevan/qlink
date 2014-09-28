CREATE DATABASE IF NOT EXISTS `qlink`;

GRANT ALL ON `qlink`.* TO 'qlinkuser'@'localhost' IDENTIFIED BY 'qlinkpass';
FLUSH PRIVILEGES;
COMMIT;