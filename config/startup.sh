#!/bin/bash

FLAG_FILE="/var/log/startup-script-ran"

# Verificar si el script ya se ha ejecutado anteriormente
if [ -f "$FLAG_FILE" ]; then
  echo "El script de inicio ya se ha ejecutado previamente. Saliendo."
  exit 0
fi

# Actualizar el sistema
apt-get update -y && apt-get upgrade -y

# Instalar paquetes necesarios
apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# Añadir clave GPG de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Añadir repositorio de Docker
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Actualizar índice de paquetes
apt-get update -y

# Instalar Docker
apt-get install -y docker-ce

# Descargar e instalar Docker Compose
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Habilitar y iniciar el servicio de Docker
systemctl enable docker
systemctl start docker

# Añadir el usuario actual al grupo docker
usermod -aG docker ${USER}

# Verificar instalación de Docker y Docker Compose
docker --version
docker-compose --version

# Crear archivo de flag para indicar que el script ya se ejecutó
touch "$FLAG_FILE"
echo "Script de inicio ejecutado y configuraciones aplicadas exitosamente."
