
#!/bin/bash
set -e

# Configurar las opciones del servidor DNS
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

# Declarar las zonas directa e inversa
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

# Copiar los archivos de zona desde la carpeta files del proyecto
cp /vagrant/files/jesuscm11.test.dns /var/lib/bind/jesuscm11.test.dns
cp /vagrant/files/jesuscm11.test.rev /var/lib/bind/jesuscm11.test.rev

# Asignar permisos al usuario de BIND
chown bind:bind /var/lib/bind/jesuscm11.test.dns /var/lib/bind/jesuscm11.test.rev

# Validar la configuración y las zonas
named-checkconf
named-checkzone jesuscm11.test /var/lib/bind/jesuscm11.test.dns
named-checkzone 56.168.192.in-addr.arpa /var/lib/bind/jesuscm11.test.rev

# Reiniciar el servidor DNS
systemctl restart named

echo "Configuracion DNS completada correctamente"
