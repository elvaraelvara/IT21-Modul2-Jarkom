apt-get update
apt-get install nginx -y
service nginx start

apt-get install lynx -y

echo "
# Default menggunakan Round Robin
upstream arjuna  {
        server 10.74.4.2:8001 ; #IP Prabukusuma
        server 10.74.4.3:8002 ; #IP Abimanyu
        server 10.74.4.4:8003 ; #IP Wissanggeni
}" > /etc/nginx/sites-available/jarkom

service nginx restart
