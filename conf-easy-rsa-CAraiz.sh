#!/bin/bash
# Bash Menu Script Example
PS3='Elige una opción del menu: '
options=("Crear estructura y iniciar PKI" "Generar certificado CA" "Crear la entidad de certificacion" "Distribuir el certificado" "Cerrar")
while true; do
select opt in "${options[@]}"
do
    case $opt in
        "Crear estructura y iniciar PKI")
            echo "Crear estructura y enlaces simbolicos"
            mkdir /home/$USER/easy-rsa
            sudo chmod 700 /home/$USER/easy-rsa
            ln -s /usr/share/easy-rsa/* /home/$USER/easy-rsa/
            cd /home/$USER/easy-rsa
            echo "PKI inicializada!..."
	    ./easyrsa init-pki
            ;;
        "Generar certificado CA")
            echo "Crear certificado CA"
           cd /home/$USER/easy-rsa
           ./easyrsa build-ca
            ;;
        "Crear la entidad de certificacion")
            echo "Creando la entidad de certificación:..."
            echo "Generando el archivo vars.."
            echo "Introduce los valores entre comillas dobles .."
           cd /home/$USER/easy-rsa
           read -p "COUNTRY?" country;
           echo set_var EASYRSA_REQ_COUNTRY $country >> vars;
           read -p "PROVINCE?" province;
           echo set_var EASYRSA_REQ_PROVINCE $province >>vars;
           read -p "CITY?" city;
           echo set_var EASYRSA_REQ_CITY $city >> vars;
           read -p "ORGANIZATION?" organitazation;
           echo set_var EASYRSA_REQ_ORG $organization >> vars;
           read -p "EMAIL?" email;
           echo set_var EASYRSA_REQ_EMAIL $email >> vars;
           read -p "ORGANIZATIONAL UNIT?" ou;
           echo set_var EASYRSA_REQ_OU $ou >> vars;
           read -p "ALGO?" algo;
           echo set_var EASYRSA_ALGO $algo >> vars;
           read -p "DIGEST?" digest;
           echo set_var EASYRSA_DIGEST $digest >> vars;
           clear
           echo "Contenido del fichero vars...."
           cat vars;
            ;;
        "Distribuir el certificado")
         echo "Distribuir el certificado.."
          cd /home/$USER/easy-rsa/pki/
         echo "Seguir la siguiente estructura para el comando scp.."
         echo "ej: user@direcciónip:/ruta destino/directorio 1"
         echo "el directorio o ruta destino debe existir.."
         read -p "¿Usuario en maquina destino?" user;
         read -p "¿IP maquina destino?" ip_dest;
         read -p  "¿Ruta de destino?" route_dest;
         scp  /home/$USER/easy-rsa/pki/ca.crt $user@$ip_dest:$route_dest;;
        "Cerrar")
            break 2
            ;;
        *) clear;
	   echo "Opción invalida, por favor elige otra opción $opt";
	   break;
    esac
done
done
