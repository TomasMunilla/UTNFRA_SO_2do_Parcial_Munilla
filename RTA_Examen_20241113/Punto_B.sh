cd /usr/local/bin
sudo vim MunillaAltaUser-Groups.sh

#!/bin/bash

LISTA=$1
USUARIO=$2

#Busco la contrasenia del usuario ingresado por parametro
# en el segundo campo de la linea con el nombre de usuario,
# en el archivo shadow
CONTRA=$(sudo grep "^$USUARIO:" /etc/shadow | cut -d':' -f2)

ANT_IFS=$IFS
IFS=$'\n'

#Leo cada linea de la lista de usuarios, ignorando los #
for i in $(grep -v '^#' "$LISTA"); do

        USUARIO=$(echo $i | awk -F ',' '{print$1}')
        GRUPO=$(echo $i | awk -F ',' '{print$2}')
        HOME_DIR=$(echo $i | awk -F ',' '{print$3}')

        #Verifico que el grupo no exista, en ese caso lo creo:
        if ! grep -q "^$GRUPO:" /etc/group; then
                sudo groupadd "$GRUPO"
        fi

        # Ya con todos los parametros listos, creo el usuario:
        sudo useradd -d "$HOME_DIR" -g "$GRUPO" -s "/bin/bash" -p "$CONTRA" "$USUARIO"
done
IFS=$ANT_IFS
