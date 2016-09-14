#!/bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
sudo a2enmod ssl
sudo service apache2 restart
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

sudo echo "<html>" > /var/www/html/index.html
sudo echo "<head>" >> /var/www/html/index.html
sudo echo "<title>Hello World</title>" >> /var/www/html/index.html
sudo echo "</head>" >> /var/www/html/index.html
sudo echo "<body>" >> /var/www/html/index.html
sudo echo "<h1>Hello World!</h1>" >> /var/www/html/index.html
sudo echo "</body>" >> /var/www/html/index.html
sudo echo "</html>" >> /var/www/html/index.html
