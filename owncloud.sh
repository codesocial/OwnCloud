#################################################################################
######################## Script Created By : Alok Chilka ########################
############################### www.codesocial.net ##############################
############################## info@codesocial.net ##############################
#################################################################################

#!/bin/bash
clear

echo "**************************************************************************";
echo -e "\t\t\t Welcome to Owncloud Installer";
echo -e "\t\t\t Command line installer";
echo "Note : please ensure to install LAMP stack prior to this installation";
echo "**************************************************************************";

echo -e "\n Downloading owncloud ......";
###wget https://download.owncloud.org/community/owncloud-9.1.7.zip


echo "**************************************************************************";
echo -e "\t\t\t Connecting to MySQL";
echo "**************************************************************************";
echo "WARNING : Please take backup of all databases as if existing database found it may be overwritten or dropped.";

read -s -p "Please type password for root : " var1

while ! mysql -u root -p$var1 -e ";" ;do
	read -s -p "Can't Connect, please retry : " var1
done


MYSQL_ROOT="root";
MYSQL_PASS=$var1;

echo -e "\n Dropping and Creating Database - owncloud";
mysql --user="$MYSQL_ROOT" --password="$MYSQL_PASS" -e "drop database if exists owncloud"
mysql --user="$MYSQL_ROOT" --password="$MYSQL_PASS" -e "create database owncloud"
mysql --user="$MYSQL_ROOT" --password="$MYSQL_PASS" -e "grant all privileges on owncloud.* to 'root@localhost' identified by 'root123'"
mysql --user="$MYSQL_ROOT" --password="$MYSQL_PASS" -e "flush privileges"
mysql --user="$MYSQL_ROOT" --password="$MYSQL_PASS" -e "show databases"


echo "**************************************************************************";
echo -e "\n\t\t\t Restarting APACHE SERVER";
echo "**************************************************************************";
sudo service apache2 restart

echo "**************************************************************************";
echo -e "\n\t\t\t Restarting MYSQL SERVER";
echo "**************************************************************************";
sudo service mysql restart

clear

echo "**************************************************************************";
echo -e "\t\t\t Creating VIRTUAL HOSTS";
echo "**************************************************************************";

echo "Enter the name for your site";
read var2;
t1='www.'
t2=$var2
t3='.conf'
t4='.com'

site=$t2$t4$t3
site2=$t2$t4

echo $site2
echo $site

echo -e "\n";

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$site

echo -e "\n 1) Edit the file as follows."
echo -e "\n 2) Look for DocumentRoot /var/www/html/ and change it to DocumentRoot /var/www/html/<your_site_name> i.e. if your site name is 'example' then change it as 'DocumentRoot /var/www/html/example'"

echo -e "\n 3) Below 'Document Root' add \n\n ServerName example.com \n ServerAlias www.example.com \n\n Replace your site name with 'example' \n Save and Exit"

sudo gedit /etc/apache2/sites-available/$site

sudo a2ensite $site2

echo -e "\n";

echo -e "\n Add the host entry for your site in /etc/hosts file \n Fr. ex. 127.0.0.1 example.com \n You can replace your IP ADDRESS with LOCALHOST IP"

sudo gedit /etc/hosts

echo -e "\n";

cd /var/www/html

sudo mkdir $var2

sudo cp /home/enigma/scripts/owncloud-9.1.7.zip /var/www/html/

cd /var/www/html/

ls -al

sudo unzip owncloud-9.1.7.zip

ls -al

sudo chown www-data:www-data -R /var/www/html/owncloud

ls -al

sudo service apache2 reload

site3=$t1$t2$t4


echo "**************************************************************************";
echo -e "n\t\t\t Launching OWNCLOUD";
echo "**************************************************************************";
google-chrome $site3





