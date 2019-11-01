apt update && apt upgrade

wget https://repo.zabbix.com/zabbix/4.0/debian/pool/main/z/zabbix-release/zabbix-release_4.0-2+stretch_all.deb

dpkg -i zabbix-release_4.0-2+stretch_all.deb

apt update

apt install zabbix-server-mysql zabbix-frontend-php zabbix-agent

mariadb