1 - Instalar zabbix agent
2 - Colocar o credileste.sh dentro de /opt

3 - Dar permissão no arquivo
# chmod +x credileste.sh

4 - Dar permissão na pasta
#chmod 755 /opt/erroATM/

5 - colocar usuario zabbix como proprietario da pasta 
# chown -R zabbix /opt/erroATM

6 - Importar template

7 - Adicionar ao crontab para rodar o script a cada 1 minuto

# crontab -e
*/1 * * * * /opt/mon.sh
