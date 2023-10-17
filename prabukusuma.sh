apt-get update && apt install nginx php php-fpm -y
php -v
apt-get install lynx -y

mkdir /var/www/jarkom

echo "
   <?php
\$hostname = gethostname();
\$date = date('Y-m-d H:i:s');
\$php_version = phpversion();
\$username = get_current_user();



echo \"Hello World!<br>\";
echo \"Saya adalah: \$username<br>\";
echo \"Saat ini berada di: \$hostname<br>\";
echo \"Versi PHP yang saya gunakan: \$php_version<br>\";
echo \"Tanggal saat ini: \$date<br>\";
?>
" > /var/www/jarkom/index.php

service php7.0-fpm start

echo "
    server {

        listen 8001;

        root /var/www/jarkom;

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

        error_log /var/log/nginx/jarkom_error.log;
        access_log /var/log/nginx/jarkom_access.log;
    }
" > /etc/nginx/sites-available/jarkom

rm -rf /etc/nginx/sites-available/default

ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled

service nginx restart

nginx -t
