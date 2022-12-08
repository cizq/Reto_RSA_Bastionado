	!/bin/sh

while true; do

	echo "-------------------------------------------";
	echo "| [ Script renovación]         |";
	echo "-------------------------------------------";
	echo " 1.- Revocar un certificado";
	echo " 2.- Generar lista de revocación de certificados";
	echo " 3.- Firmar un certificado";
	echo " 4.- Salir del programa";	
	echo "\n";


	read -p "Seleccione una opción de las siguientes: " op
	case $op in
		[1]* )	 echo "Revocar certificado";
			   cd /home/$USER/easy-rsa
			 echo "Introduce el nombre del certificado a revocar.."
                         read -p  "nombre del certificado.." cert;
                         ./easyrsa revoke $cert;;

		[2]* )	 echo "Generar lista de revocación de certificados...";
			   cd /home/$USER/easy-rsa/;
			   ./easyrsa gen-crl;
			 echo "Lista de revocación generada....";;
		[3]* )
			 echo "Firma un certificado";
			 echo "Introduce el nombre del certificado a firmar";
			 echo "El certificado debe haber sido importado previamente...";
			 read -p "Introduce el tipo de certificado (client,server o ca...)  " tipocer;
			 read -p "Introduce el nombre del certificado  " cert;
			 cd /home/$USER/easy-rsa
			 ./easyrsa sign-req  $tipocer $cert;;
  		[4]*)    echo "Ha escogido salir del programa. Hasta luego.";
                         break;;

		* ) clear;
		    echo "Opción incorrecta, vuelve a seleccionar.\n";;
	esac
done
