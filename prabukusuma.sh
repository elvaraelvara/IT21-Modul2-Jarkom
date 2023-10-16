apt-get update && apt install nginx php php-fpm -y
php -v
apt-get install lynx -y

mkdir /var/www/prabukusuma

echo "
    <?php
    echo \"Halo Prabukusuma\";
    ?>
" > /var/www/prabukusuma/index.php

service php7.0-fpm start

echo "
    server {

        listen 80;

        root /var/www/prabukusuma;

        index index.php index.html index.htm;
        server_name _;

        location / {
                try_files \$uri \$uri/ /index.php?\$query_string;
        }

        # pass PHP scripts to FastCGI server
        location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
        }

    location ~ /\.ht {
                deny all;
        }

        error_log /var/log/nginx/prabukusuma_error.log;
        access_log /var/log/nginx/prabukusuma_access.log;
    }
" > /etc/nginx/sites-available/prabukusuma

rm -rf /etc/nginx/sites-available/default

ln -s /etc/nginx/sites-available/prabukusuma /etc/nginx/sites-enabled

service nginx restart

nginx -t