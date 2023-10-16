apt-get update
apt-get install nginx -y
apt-get install lynx -y

echo "
# Default menggunakan Round Robin
upstream arjuna  {
    	server 10.74.4.2:8001 ; #IP Prabukusuma
        server 10.74.4.3:8002 ; #IP Abimanyu
        server 10.74.4.4:8003 ; #IP Wissanggeni
}

 server {
    	listen 80;
    	server_name arjuna.IT21.com;

    	location / {
            	proxy_pass http://arjuna;
    	}
}" > /etc/nginx/sites-available/arjuna

rm -rf /etc/nginx/sites-available/default
ln -s /etc/nginx/sites-available/arjuna /etc/nginx/sites-enabled

service nginx restart
