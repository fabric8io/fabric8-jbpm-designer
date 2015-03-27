__setup_mysql() {
	echo "Running the start_mysql function."
	mysqladmin -u root password mysqlPassword
	mysql -uroot -pmysqlPassword -e "create database jbpm;"
	mysql -uroot -pmysqlPassword -e "create user 'jbpm'@'localhost' identified by 'jbpm';"
	mysql -uroot -pmysqlPassword -e "grant all privileges on jbpm.* to 'jbpm'@'localhost' with grant option;"

	mysql -ujbpm -pjbpm jbpm < /opt/jbpm/jbpm-installer/db/ddl-scripts/mysql5/mysql5-jbpm-schema.sql
	mysql -ujbpm -pjbpm jbpm < /opt/jbpm/jbpm-installer/db/ddl-scripts/mysql5/quartz_tables_mysql.sql
}

mysql_install_db
chown -R mysql:mysql /var/lib/mysql
/usr/bin/mysqld_safe & 
sleep 5

__setup_mysql
