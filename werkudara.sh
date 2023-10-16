apt-get update
apt-get install bind9 -y

echo "
    zone \"arjuna.IT21.com\" {
        type slave;
        masters { 10.74.1.2; };
        file \"/var/lib/bind/arjuna.IT21.com\";
    };

    zone \"abimanyu.IT21.com\" {
        type slave;
        masters { 10.74.1.2; };
        file \"/var/lib/bind/abimanyu.IT21.com\";
    };

    zone \"baratayuda.abimanyu.IT21.com\" {
        type master;
        file \"/etc/bind/baratayuda/baratayuda.abimanyu.IT21.com\";
    };
" > /etc/bind/named.conf.local

mkdir /etc/bind/baratayuda

echo "
\$TTL 604800
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
" > /etc/bind/baratayuda/baratayuda.abimanyu.IT21.com

echo "
    options {
            directory \"/var/cache/bind\";

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
" > /etc/bind/named.conf.options

service bind9 restart