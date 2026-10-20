#!/bin/bash
set -e

echo "Comprobando el registro A..."
dig @127.0.0.1 debian.jesuscm11.test +short | grep -Fx "192.168.56.10"

echo "Comprobando el registro CNAME..."
dig @127.0.0.1 web.jesuscm11.test CNAME +short | grep -Fx "debian.jesuscm11.test."

echo "Comprobando el registro TXT..."
dig @127.0.0.1 jesuscm11.test TXT +short | grep -Fx '"jesuscm11"'

echo "Comprobando el registro PTR..."
dig @127.0.0.1 -x 192.168.56.10 +short | grep -Fx "debian.jesuscm11.test."

echo "Todas las pruebas DNS han terminado correctamente."
