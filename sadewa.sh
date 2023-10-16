apt-get update
apt-get install dnsutils -y
apt-get install lynx -y

echo "
 #nameserver 192.168.122.1
nameserver 10.74.1.2
nameserver 10.74.2.2
nameserver 10.74.4.5
nameserver 10.74.4.3
" > /etc/resolv.conf