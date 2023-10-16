# INI BELOM KELAR YA AL OKEEEEEE
# IT21-Modul2-Jarkom

- Maria Teresia Elvara Bumbungan (5027211042)
- Nathania Elirica Aliyah (5027211057)
## Nomor 1

- Membuat Topolgi 
![Teks Alternatif](https://i.ibb.co/CwY9NNW/image.png)


## Nomor 2 dan 3 

### Yudhistira
- nano /etc/bind/named.conf.local
```bash
zone "arjuna.IT21.com" {
	type master;
	file "/etc/bind/arjuna/arjuna.it21.com";
};
zone "abimanyu.IT21.com" {
	type master;
	file "/etc/bind/abimanyu/abimanyu.it21.com";
};
```
- mkdir /etc/bind/arjuna
- nano /etc/bind/arjuna/arjuna.IT21.com
```bash
$TTL 604800
@       IN      SOA arjuna.IT21.com. root.arjuna.IT21.com. (
        1       ; Serial
        604800  ; Refresh
        86400   ; Retry
        2419200 ; Expire
        604800 )        ; Negative Cache TTL
;
@       IN      NS      arjuna.IT21.com.
@       IN      A       10.74.4.5
www     IN      CNAME   arjuna.IT21.com.
```
- mkdir /etc/bind/abimanyu
- nano /etc/bind/abimanyu/abimanyu.IT21.com
```bash
$TTL 604800
@       IN      SOA abimanyu.IT21.com. root.abimanyu.IT21.com. (
        1       ; Serial
        604800  ; Refresh
        86400   ; Retry
        2419200 ; Expire
        604800 )        ; Negative Cache TTL
;
@       IN      NS      abimanyu.IT21.com.
@       IN      A       10.74.4.3
www     IN      CNAME   abimanyu.IT21.com.
```
- service bind9 restart

### Nakula dan Sadewa
- apt-get update
- apt-get install dnsutils
- nano /etc/resolv.conf
```bash
nameserver 10.74.1.2
nameserver 10.74.4.5
nameserver 10.74.4.3
```
### Testing
#### Nakula dan Sadewa
- ping abimanyu.IT21.com
![Teks Alternatif]()
- ping arjuna.IT21.com
![Teks Alternatif]()

## Nomor 4
### Yudhistira
- nano /etc/bind/abimanyu/abimanyu.IT21.com
```bash
$TTL 604800
@       IN      SOA     abimanyu.IT21.com. root.abimanyu.IT21.com. (
        1       ; Serial
        604800  ; Refresh
        86400   ; Retry
        2419200 ; Expire
        604800 )        ; Negative Cache TTL
;

@       IN      NS      abimanyu.IT21.com.
@       IN      A       10.74.4.3
www     IN      CNAME   abimanyu.IT21.com.
parikesit       IN      A       10.74.4.3
```
- service bind9 restart

### Testing
#### Nakula dan Sadewa
- ping parikesit.abimanyu.IT21.com
![Teks Alternatif]()

## Nomor 5

### Yudhistira

- nano /etc/bind/named.conf.local
```bash
zone "3.4.74.10.in-addr.arpa" {
	type master;
        file "/etc/bind/abimanyu/3.4.74.10.in-addr.arpa";
};'
```

- nano /etc/bind/abimanyu/3.4.74.10.in-addr.arpa
```bash
 $TTL 604800
@       IN      SOA     abimanyu.IT21.com root.abimanyu.IT21.com. (
        1       ; Serial
        604800  ; Refresh
        86400   ; Retry
        2419200 ; Expire
        604800 )        ; Negative Cache TTL
;

@       IN      NS abimanyu.IT21.com
3       IN      PTR     abimanyu.IT21.com.
```

### Testing
#### Nakula dan Sadewa
- host -t PTR 10.74.4.3
![Teks Alternatif]()

## Nomor 6 DNS SLAVE

### Yudhistira
- nano /etc/bind/named.conf.local
```
zone “arjuna.IT21.com” {
	type master;
	notify yes;
	also-notify { 10.74.2.2; }; #IP Werkudara
	allow-transfer { 10.74.2.2; };
	file “/etc/bind/arjuna/arjuna.IT21.com”
};
zone “abimanyu.IT21.com” {
	type master;
	notify yes;
	also-notify { 10.74.2.2; }; #IP Werkudara
	allow-transfer { 10.74.2.2; };
	file “/etc/bind/abimanyu/abimanyu.IT21.com”
};
```

- service bind9 restart

### Werkudara
- apt-get update
- apt-get install bind9
- nano /etc/bind/named.conf.local
```
zone “arjuna.IT21.com” {
	type slave;
	masters { 10.74.1.2; }; #IP  Yudhistira
	file “/var/lib/bind/arjuna.IT21.com”;
};
zone “abimanyu.IT21.com” {
	type slave;
	masters { 10.74.1.2; }; #IP  Yudhistira
	file “/var/lib/bind/abimanyu.IT21.com”;
};
```

- service bind9 restart

### Yudhistira
- service bind9 stop


### Testing
#### Sadewa dan Nakula
- nano /etc/resolv.conf
```bash
nameserver 10.74.1.2
nameserver 10.47.2.2
nameserver 10.74.4.5
nameserver 10.74.4.3
```
- ping arjuna.IT21.com -c 5
![image1]()


- ping abimanyu.IT21.com -c 5
![image25]()

## Nomor 7
### Yudhistira

- nano /etc/bind/abimanyu/abimanyu.IT21.com
```bash
$TTL 604800
@       IN      SOA     abimanyu.IT21.com. root.abimanyu.IT21.com. (
        1       ; Serial
        604800  ; Refresh
        86400   ; Retry
        2419200 ; Expire
        604800 )        ; Negative Cache TTL
;

@       IN      NS      abimanyu.IT21.com.
@       IN      A       10.74.4.3
www     IN      CNAME   abimanyu.IT21.com.
parikesit       IN      A       10.74.4.3
ns1     IN      A       10.74.2.2
baratayuda      IN      NS      ns1
```
- nano /etc/bind/named.conf.options
```bash
options {
	directory \"/var/cache/bind\";

	// Uncomment the following block if you want to specify forwarders.
	// Replace 0.0.0.0 with the actual IP addresses of your forwarders.
	// forwarders {
	//    0.0.0.0;
	// };

	//========================================================================
	// If BIND logs error messages about the root key being expired,
	// you will need to update your keys. See https://www.isc.org/bind-keys
	//========================================================================
	// dnssec-validation auto;

	allow-query { any; };
	auth-nxdomain no; # conform to RFC1035
	listen-on-v6 { any; };
};
```


- service bind9 restart

### Werkudara
- apt-get update
- apt-get install bind9
- mkdir /etc/bind/baratayuda
- nano /etc/bind/named.conf.options
```bash
 options {
            directory \"/var/cache/bind";

            // If there is a firewall between you and nameservers you want
            // to talk to, you may need to fix the firewall to allow multiple
            // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

            // If your ISP provided one or more IP addresses for stable
            // nameservers, you probably want to use them as forwarders.
            // Uncomment the following block, and insert the addresses replacing
            // the all-0's placeholder.

            // forwarders {
            //      0.0.0.0;
            // };

            //========================================================================
            // If BIND logs error messages about the root key being expired,
            // you will need to update your keys.  See https://www.isc.org/bind-keys
            //========================================================================
            //dnssec-validation auto;

            allow-query{any;};

            auth-nxdomain no;    # conform to RFC1035
            listen-on-v6 { any; };
    };
```

- nano /etc/bind/named.conf.local
```bash
 zone "baratayuda.abimanyu.IT21.com" {

        type master;

        file "/etc/bind/baratayuda/baratayuda.abimanyu.IT21.com";

    };
```
- nano etc/bind/baratayuda/baratayuda.abimanyu.IT21.com
```bash
$TTL 604800
@       IN      SOA     baratayuda.abimanyu.IT21.com. root.baratayuda.abimanyu.IT21.com. (
        1       ; Serial
        604800  ; Refresh
        86400   ; Retry
        2419200 ; Expire
        604800 )        ; Negative Cache TTL
;

@       IN      NS      baratayuda.abimanyu.IT21.com.
@       IN      A       10.74.4.3
www     IN      CNAME   baratayuda.abimanyu.IT21.com.
```

- service bind9 restart

### Testing
#### Nakula dan Sadewa
- ping baratayuda.abimanyu.IT21.com
![image28]()
-  ping www.baratayuda.abimanyu.IT21.com 
![image28]()

## Nomor 8
### Yudhistira
- nano /etc/bind/abimanyu/abimanyu.IT21.com
```bash
$TTL 604800
@       IN      SOA     abimanyu.IT21.com. root.abimanyu.IT21.com. (
        1       ; Serial
        604800  ; Refresh
        86400   ; Retry
        2419200 ; Expire
        604800 )        ; Negative Cache TTL
;

@       IN      NS      abimanyu.IT21.com.
@       IN      A       10.74.4.3
www     IN      CNAME   abimanyu.IT21.com.
parikesit       IN      A       10.74.4.3
ns1     IN      A       10.74.2.2
baratayuda      IN      NS      ns1
```
- service bind9 restart

### Werkudara
- nano /etc/bind/baratayuda/baratayuda.abimanyu.IT21.com
```bash
$TTL 604800
@       IN      SOA     baratayuda.abimanyu.IT21.com. root.baratayuda.abimanyu.IT21.com. (
        1       ; Serial
        604800  ; Refresh
        86400   ; Retry
        2419200 ; Expire
        604800 )        ; Negative Cache TTL
;

@       IN      NS      baratayuda.abimanyu.IT21.com.
@       IN      A       10.74.4.3
www     IN      CNAME   baratayuda.abimanyu.IT21.com.
rjp     IN      A       10.74.4.3
www.rjp IN      CNAME   baratayuda.abimanyu.IT21.com.
```
- service bind9 restart

### Testing
#### Nakula dan Sadewa
- ping rjp.baratayuda.abimanyu.IT21.com 
![image2]()
- ping www.rjp.baratayuda.abimanyu.IT21.com
![image2]()

## Nomor 9
### Worker (Prabukusuma, Abimanyu, Wisanggeni)
Lakukan hal yang sama di ketiga worker dengan menyesuaikan port pada soal

- apt-get update && apt install nginx php php-fpm -y
- php -v
- apt-get install lynx -y
- apt-get install nginx -y
- mkdir /var/www/jarkom

- nano /var/www/jarkom/index.php
```bash
<?php
$hostname = gethostname();
$date = date('Y-m-d H:i:s');
$php_version = phpversion();
$username = get_current_user();

echo "Hello World!<br>";
echo "Saya adalah: $username<br>";
echo "Saat ini berada di: $hostname<br>";
echo "Versi PHP yang saya gunakan: $php_version<br>";
echo "Tanggal saat ini: $date<br>";
?>
```
- service php7.0-fpm start

- nano /etc/nginx/sites-available/jarkom
``` server {

        listen 80;

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
```
- rm -rf /etc/nginx/sites-available/default

- ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled

- service nginx restart

- nginx -t

### Testing
#### Nakula dan Sadewa
- apt-get update
- apt-get install lynx
- lynx http://10.74.4.2
![image10]()
- lynx http://10.74.4.3
![image31]()
- lynx http://10.74.4.4
![image32]()

## Nomor 10
### Arjuna
- nano /etc/nginx/sites-available/arjuna.IT21.com
```
echo 'upstream back {
  server 192.243.2.5:8001; # IP PrabuKusuma
  server 192.243.2.4:8002; # IP Abimanyu
  server 192.243.2.6:8003; # IP Wisanggeni
}

server {
  listen 80;
  server_name arjuna.IT21.com www.arjuna.IT21.com;

  location / {
    proxy_pass http://back;
  }
}
```

- ln -s /etc/nginx/sites-available/jarkom /etc/nginx/sites-enabled/jarkom

- rm /etc/nginx/sites-enabled/default

- service nginx restart



## Nomor 11
### Abimanyu

-  cd /var/www
- wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1a4V23hwK9S7hQEDEcv9FL14UkkrHc-Zc' -O abimanyu
- unzip abimanyu -d abimanyu.IT21
- mv abimanyu.IT21/abimanyu.yyy.com/* abimanyu.IT21
- rmdir abimanyu.it03/abimanyu.yyy.com
- nano /etc/apache2/sites-available/abimanyu.IT21.conf
```bash
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

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with \"a2disconf\".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>
```

- a2ensite abimanyu.IT21.conf
- service apache2 restart

### Testing
#### Nakula dan Sadewa
- lynx http://www.abimanyu.IT21.com`.
![image27]()

## Nomor 12
### Abimanyu
- nano /etc/apache2/sites-available/abimanyu.IT21.conf
```bash
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

        Alias \"/public\" \"/var/www/parikesit.abimanyu.IT21/public\"
        Alias \"/secret\" \"/var/www/parikesit.abimanyu.IT21/secret\"
        

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
```
- service apache2 restart

### Testing
#### Nakula dan Sadewa

- lynx http://www.abimanyu.IT21.com/home
![image2]()

## Nomor 13
### Abimanyu
- nano /etc/apache2/sites-available/parikesit.abimanyu.IT21.com.conf
```bash
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

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with \"a2disconf\".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>
```
- a2ensite parikesit.abimanyu.IT21.com.conf

- service apache2 restart

### Testing
#### Nakula dan Sadewa
- lynx parikesit.abimanyu.IT21.com
![image2]()


## Nomor 14

### Abimanyu
- nano /etc/apache2/sites-available/parikesit.abimanyu.it21.com
tambahkan code berikut
  ```
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

        Alias \"/public\" \"/var/www/parikesit.abimanyu.IT21/public\"
        Alias \"/secret\" \"/var/www/parikesit.abimanyu.IT21/secret\"
       
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
```
- service apache2 restart

### Testing
#### Nakula dan Sadewa

- lynx http://www.parikesit.abimanyu.IT21.com/public
![image40]()

- lynx http://www.parikesit.abimanyu.IT21.com/secret
![image20]()

## Nomor 15
### Abimanyu
- nano /etc/apache2/sites-available/parikesit.abimanyu.it03.conf 
Tambahkan code berikut:
```
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
```

- service apache2 restart

### Testing
Masukan command dibawah untuk periksa keberhasilan:
1. lynx http://parikesit.abimanyu.IT21.com/error
custom 404 not found
![image12]()

2. lynx http://parikesit.abimanyu.IT21.com/secret
custom 403 forbidden
![image3]()

## Nomor 16
### Abimanyu
- nano /etc/sites-available/parikesit.abimanyu.IT21.conf
```
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
```
### Testing
#### Nakula dan Sadewa
- lynx http://www.parikesit.abimanyu.IT21.com/js
![image33]()

# Nomor 17
## Abimanyu
- nano /etc/apache2/sites-available/rjp.baratayuda.abimanyu.IT21.com.conf
```bash
<VirtualHost *:14000 *:14400>
  ServerAdmin webmaster@localhost
  DocumentRoot /var/www/rjp.baratayuda.abimanyu.IT21
  ServerName rjp.baratayuda.abimanyu.IT21.com
  ServerAlias www.rjp.baratayuda.abimanyu.IT21.com

  ErrorLog \${APACHE_LOG_DIR}/error.log
  CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```
- nano /etc/apache2/ports.conf
```bash
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
```
### Testing
#### Nakula dan Sadewa

- lynx http://www.rjp.baratayuda.abimanyu.IT21.com
![image23]()

- lynx http://www.rjp.baratayuda.abimanyu.IT21.com:14000
![image23]()

- lynx http://www.rjp.baratayuda.abimanyu.IT21.com:14400
![image23]()

## Nomor 18
### Abimanyu
- nano /etc/apache2/sites-available/rjp.baratayuda.abimanyu.it03.com
```
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

  ErrorLog \${APACHE_LOG_DIR}/error.log
  CustomLog \${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
```

- cd /etc/apache2/sites-available/
- htpasswd -c /etc/apache2/.htpasswd Wayang (kemudian, masukkan password baratayudaIT21)
### Testing 
#### Nakula dan Sadewa
- lynx http://www.rjp.baratayuda.abimanyu.IT21.com (tanpa auth)`
![image56]()
- lynx http://www.rjp.baratayuda.abimanyu.IT21.com:14000 -u Wayang:baratayudaIT21`
![image28]()
