#!/bin/bash
set -e

apt-get update
apt-get install -y bind9 bind9utils bind9-doc dnsutils

echo "Instalacion completada correctamente"
