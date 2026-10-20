# Configuración de un servidor DNS con BIND9

**Autor:** Jesús Caballero Martín

## Descripción

Práctica de configuración de un servidor DNS con BIND9 sobre Debian 12, utilizando Vagrant y VirtualBox para automatizar la instalación y configuración.

## Requisitos

- VirtualBox.
- Vagrant.
- Git.

## Configuración

- **Sistema operativo:** Debian 12 (Bookworm).
- **Servidor DNS:** BIND9.
- **Dominio:** `jesuscm11.test`.
- **Dirección IP:** `192.168.56.10`.
- **Zona directa:** `jesuscm11.test`.
- **Zona inversa:** `56.168.192.in-addr.arpa`.

## Registros DNS

| Tipo | Nombre | Función |
|---|---|---|
| A | `debian.jesuscm11.test` | Asocia el nombre con la IP `192.168.56.10`. |
| CNAME | `web.jesuscm11.test` | Crea un alias para el servidor. |
| TXT | `jesuscm11.test` | Almacena el texto `jesuscm11`. |
| PTR | `192.168.56.10` | Permite la resolución inversa. |

## Cómo iniciar el servidor

Desde la carpeta del proyecto, ejecutar:

`
vagrant up
`

Para comprobar los registros DNS, entrar en la máquina virtual:

`
vagrant ssh
`

Y ejecutar dentro de Debian:

`
sudo bash /vagrant/config/03_test_dns.sh
`

## Estructura del proyecto

- `Vagrantfile`: configuración de la máquina virtual.
- `config/01_install_dns.sh`: instalación de BIND9 y herramientas DNS.
- `config/02_configure_dns.sh`: configuración del servidor y las zonas.
- `config/03_test_dns.sh`: pruebas de los registros DNS.
- `files/`: archivos de las zonas directa e inversa.
- `doc/README.md`: documentación detallada de la práctica.

## Resultado

Las pruebas de los registros A, CNAME, TXT y PTR han finalizado correctamente.
