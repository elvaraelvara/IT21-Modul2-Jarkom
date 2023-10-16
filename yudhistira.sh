apt-get update
apt-get install bind9 -y

echo '
zone "arjuna.IT21.com" {
	type master;
        notify yes;
        also-notify { 10.74.2.2; };
        allow-transfer { 10.74.2.2; };
        file "/etc/bind/arjuna/arjuna.IT21.com";
};
zone "abimanyu.IT21.com" {
	type master;
	file "/etc/bind/abimanyu/abimanyu.IT21.com";
	allow-transfer { 10.74.2.2; };
};
zone "3.4.74.10.in-addr.arpa" {
	type master;
        file "/etc/bind/abimanyu/3.4.74.10.in-addr.arpa";
};' > /etc/bind/named.conf.local

mkdir /etc/bind/arjuna
mkdir /etc/bind/abimanyu

echo "
\$TTL 604800
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

" > /etc/bind/arjuna/arjuna.IT21.com

echo "
\$TTL 604800
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
" > /etc/bind/abimanyu/abimanyu.IT21.com


echo "
\$TTL 604800
@       IN      SOA     abimanyu.IT21.com. root.abimanyu.IT21.com. (
        2023091001       ; Serial
        604800  ; Refresh
        86400   ; Retry
        2419200 ; Expire
        604800 )        ; Negative Cache TTL
;

@       IN      NS abimanyu.IT21.com.
3       IN      PTR     abimanyu.IT21.com.
" > /etc/bind/abimanyu/3.4.74.10.in-addr.arpa

echo "
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
};" > /etc/bind/named.conf.options

service bind9 restart