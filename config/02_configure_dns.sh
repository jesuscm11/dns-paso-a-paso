#!/bin/bash
set -e

cat > /etc/bind/named.conf.options <<'EOF'
acl confiables {
    127.0.0.1;
    192.168.56.0/24;
};

options {
    directory "/var/cache/bind";
    allow-transfer { none; };
    listen-on port 53 { 127.0.0.1; 192.168.56.10; };
    listen-on-v6 { none; };
    recursion yes;
    allow-recursion { confiables; };
    dnssec-validation yes;
};
EOF

cat > /etc/bind/named.conf.local <<'EOF'
zone "jesuscm11.test" {
    type master;
    file "/var/lib/bind/jesuscm11.test.dns";
};

zone "56.168.192.in-addr.arpa" {
    type master;
    file "/var/lib/bind/jesuscm11.test.rev";
};
EOF

cat > /var/lib/bind/jesuscm11.test.dns <<'EOF'
$TTL 86400
@ IN SOA debian.jesuscm11.test. admin.jesuscm11.test. (
    2026102001
    3600
    1800
    604800
    86400
)
@ IN NS debian.jesuscm11.test.
debian IN A 192.168.56.10
web IN CNAME debian.jesuscm11.test.
@ IN TXT "jesuscm11"
EOF

cat > /var/lib/bind/jesuscm11.test.rev <<'EOF'
$TTL 86400
@ IN SOA debian.jesuscm11.test. admin.jesuscm11.test. (
    2026102001
    3600
    1800
    604800
    86400
)
@ IN NS debian.jesuscm11.test.
10 IN PTR debian.jesuscm11.test.
EOF

chown bind:bind /var/lib/bind/jesuscm11.test.dns /var/lib/bind/jesuscm11.test.rev

named-checkconf
named-checkzone jesuscm11.test /var/lib/bind/jesuscm11.test.dns
named-checkzone 56.168.192.in-addr.arpa /var/lib/bind/jesuscm11.test.rev

systemctl restart named