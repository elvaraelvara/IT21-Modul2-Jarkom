apt-get update && apt install nginx php php-fpm -y
php -v
apt-get install lynx -y
apt-get install apache2 -y
apt-get install libapache2-mod-php7.0 -y
service apache2 start
apt-get install wget -y
apt-get install unzip -y

mkdir /var/www/abimanyu

echo "
    <?php
    echo \"Halo Abimanyu\";
    ?>
" > /var/www/abimanyu/index.php

service php7.0-fpm start

echo "
    server {

        listen 8002;

        root /var/www/abimanyu;

        index index.php index.html index.htm;
        server_name _;

        location / {
                try_files \$uri \$uri/ /index.php?\$query_string;
        }

        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        }

    location ~ /\.ht {
                deny all;
        }

        error_log /var/log/nginx/abimanyu_error.log;
        access_log /var/log/nginx/abimanyu_access.log;
    }
" > /etc/nginx/sites-available/abimanyu

rm -rf /etc/nginx/sites-available/default

ln -s /etc/nginx/sites-available/abimanyu /etc/nginx/sites-enabled

service nginx restart

nginx -t

wget -O '/var/www/abimanyu.IT21.com' 'https://drive.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc'
unzip -o /var/www/abimanyu.IT21.com -d /var/www/
mv /var/www/abimanyu.yyy.com /var/www/abimanyu.IT21
rm /var/www/abimanyu.IT21.com
rm -rf /var/www/abimanyu.yyy.com

cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/abimanyu.IT21.com.conf
rm /etc/apache2/sites-available/000-default.conf

echo "
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/abimanyu.IT21
        ServerName abimanyu.IT21.com
        ServerAlias www.abimanyu.IT21.com

        <Directory /var/www/abimanyu.IT21/index.php/home>
                Options +Indexes
        </Directory>

        Alias \"/home\" \"/var/www/abimanyu.IT21/index.php/home\"

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with \"a2disconf\".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" > /etc/apache2/sites-available/abimanyu.IT21.com.conf

a2ensite abimanyu.IT21.com.conf

wget -O '/var/www/parikesit.abimanyu.IT21.com' 'https://drive.google.com/uc?export=download&id=1LdbYntiYVF_NVNgJis1GLCLPEGyIOreS'
unzip -o /var/www/parikesit.abimanyu.IT21.com -d /var/www/
mv /var/www/parikesit.abimanyu.yyy.com /var/www/parikesit.abimanyu.IT21
rm /var/www/parikesit.abimanyu.IT21.com
rm -rf /var/www/parikesit.abimanyu.yyy.com
mkdir /var/www/parikesit.abimanyu.IT21/secret

a2enmod rewrite

echo "
<VirtualHost *:80>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/parikesit.abimanyu.IT21
        ServerName parikesit.abimanyu.IT21.com
        ServerAlias www.parikesit.abimanyu.IT21.com

        <Directory /var/www/parikesit.abimanyu.IT21/public>
                Options +Indexes
        </Directory>

        <Directory /var/www/parikesit.abimanyu.IT21/secret>
                Options -Indexes
        </Directory>

        <Directory /var/www/parikesit.abimanyu.IT21>
            Options +FollowSymLinks -Multiviews
            AllowOverride All
        </Directory>

        Alias \"/public\" \"/var/www/parikesit.abimanyu.IT21/public\"
        Alias \"/secret\" \"/var/www/parikesit.abimanyu.IT21/secret\"
        Alias \"/js\" \"/var/www/parikesit.abimanyu.IT21/public/js\"

        RewriteEngine On
        RewriteCond %{REQUEST_URI} ^/public/images/(.*)(abimanyu)(.*\.(png|jpg))
        RewriteCond %{REQUEST_URI} !/public/images/abimanyu.png
        RewriteRule abimanyu http://parikesit.abimanyu.IT21.com/public/images/abimanyu.png\$1 [L,R=301]

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorDocument 404 /error/404.html
        ErrorDocument 403 /error/403.html

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with \"a2disconf\".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" > /etc/apache2/sites-available/parikesit.abimanyu.IT21.com.conf

a2ensite parikesit.abimanyu.IT21.com.conf

wget -O '/var/www/rjp.baratayuda.abimanyu.IT21.com' 'https://drive.google.com/uc?export=download&id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6'
unzip -o /var/www/rjp.baratayuda.abimanyu.IT21.com -d /var/www/
mv /var/www/rjp.baratayuda.abimanyu.yyy.com /var/www/rjp.baratayuda.abimanyu.IT21
rm /var/www/rjp.baratayuda.abimanyu.IT21.com
rm -rf /var/www/rjp.baratayuda.abimanyu.yyy.com

echo "
<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.IT21
  ServerName rjp.baratayuda.abimanyu.IT21.com
  ServerAlias www.rjp.baratayuda.abimanyu.IT21.com

  <Directory /var/www/rjp.baratayuda.abimanyu.IT21>
          AuthType Basic
          AuthName \"Restricted Content\"
          AuthUserFile /etc/apache2/.htpasswd
          Require valid-user
  </Directory>

  ErrorDocument 404 /error/404.html
  ErrorDocument 403 /error/403.html

  ErrorLog \${APACHE_LOG_DIR}/error.log
  CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.IT21.com.conf

echo "
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet
" > /etc/apache2/ports.conf

a2ensite rjp.baratayuda.abimanyu.IT21.com.conf

htpasswd -c -b /etc/apache2/.htpasswd Wayang baratayudaaIT21

echo "
<VirtualHost *:80>
    ServerAdmin webmaster@abimanyu.IT21.com
    DocumentRoot /var/www/html

    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined

    Redirect / http://www.abimanyu.IT21.com/
</VirtualHost>
" > /etc/apache2/sites-available/000-default.conf

service apache2 restart
