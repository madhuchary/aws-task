#!/bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
sudo apt-get install crul -y 

sudo echo "<html>" > /var/www/html/index.html
sudo echo "<head>" >> /var/www/html/index.html
sudo echo "<meta http-equiv=\"refresh\" content=\"0;URL=https://`curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`/\" />" >> /var/www/html/index.html
sudo echo "<title>Hello World</title>" >> /var/www/html/index.html
sudo echo "</head>" >> /var/www/html/index.html
sudo echo "<body>" >> /var/www/html/index.html
sudo echo "<h1>Hello World!</h1>" >> /var/www/html/index.html
sudo echo "</body>" >> /var/www/html/index.html
sudo echo "</html>" >> /var/www/html/index.html

sudo a2enmod ssl
sudo service apache2 restart
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

echo '<IfModule mod_ssl.c>' > /etc/apache2/sites-available/default-ssl.conf
echo    '<VirtualHost _default_:443>' >> /etc/apache2/sites-available/default-ssl.conf
echo        'ServerAdmin webmaster@localhost' >> /etc/apache2/sites-available/default-ssl.conf
echo        'DocumentRoot /var/www/html' >> /etc/apache2/sites-available/default-ssl.conf
echo        'ErrorLog ${APACHE_LOG_DIR}/error.log' >> /etc/apache2/sites-available/default-ssl.conf
echo        'CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/sites-available/default-ssl.conf
echo        'SSLEngine on' >> /etc/apache2/sites-available/default-ssl.conf
echo        'SSLCertificateFile /etc/ssl/certs/ssl-cert-snakeoil.pem' >> /etc/apache2/sites-available/default-ssl.conf
echo        'SSLCertificateKeyFile /etc/ssl/private/ssl-cert-snakeoil.key' >> /etc/apache2/sites-available/default-ssl.conf
echo        '<FilesMatch "\.(cgi|shtml|phtml|php)$">' >> /etc/apache2/sites-available/default-ssl.conf
echo        '                SSLOptions +StdEnvVars' >> /etc/apache2/sites-available/default-ssl.conf
echo        '</FilesMatch>' >> /etc/apache2/sites-available/default-ssl.conf
echo        '<Directory /usr/lib/cgi-bin>' >> /etc/apache2/sites-available/default-ssl.conf
echo         '               SSLOptions +StdEnvVars' >> /etc/apache2/sites-available/default-ssl.conf
echo        '</Directory>' >> /etc/apache2/sites-available/default-ssl.conf
echo        'BrowserMatch "MSIE [2-6]" \' >> /etc/apache2/sites-available/default-ssl.conf
echo         '               nokeepalive ssl-unclean-shutdown \' >> /etc/apache2/sites-available/default-ssl.conf
echo          '              downgrade-1.0 force-response-1.0' >> /etc/apache2/sites-available/default-ssl.conf
echo        'BrowserMatch "MSIE [17-9]" ssl-unclean-shutdown' >> /etc/apache2/sites-available/default-ssl.conf
echo    '</VirtualHost>' >> /etc/apache2/sites-available/default-ssl.conf
echo '</IfModule>'  >> /etc/apache2/sites-available/default-ssl.conf

#echo 'RewriteEngine On' > /var/www/html/.htaccess
#echo 'RewriteCond %{HTTPS} off' >> /var/www/html/.htaccess
#echo 'RewriteRule (.*) https://%{SERVER_NAME}/%$1 [R,L]' >> /var/www/html/.htaccess

sudo a2ensite default-ssl.conf
sudo service apache2 restart
