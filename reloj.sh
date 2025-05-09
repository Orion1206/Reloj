#!/bin/bash

usu=$(whoami)
ubi=$(find /home/$usu/ -name funciones.sh)
source $ubi

clear

while true;do
	read -n 1 -p "Modo deseado (h para la ayuda): " mod
	echo ""
	if [ -z $mod ] || { [ $mod != "h" ] && [ $mod != "r" ] && [ $mod != "c" ] && [ $mod != "t" ]; };then
		fcolores 31 OPCION NO VALIDA
		echo ""
	else
		break
	fi
done

while true;do
	case $mod in
		h)
		clear
		fcolores 33 "======================"
		fcolores 33 "   Menu De Ayuda"
		fcolores 33 "======================"
		echo "r: Modo Reloj"
		echo "c: Modo Cronometro"
		echo "t: Modo Temporizador"
		fcolores 33 "======================"
		echo ""
		fcolores 32 Presione z para continuar
		while true;do
			read -s -n 1 salir
			if [ $salir = z ];then
				break
			fi
		done
		while true;do
			read -n 1 -p "Modo deseado (h para la ayuda): " mod
			echo ""
			if [ -z $mod ] || { [ $mod != "h" ] && [ $mod != "r" ] && [ $mod != "c" ] && [ $mod != "t" ]; };then
				fcolores 31 OPCION NO VALIDA
				echo ""
			else
				break
			fi
		done
		;;
		r)
		echo "Presiona z para salir"
		sleep 1
		stty -echo
		while true;do
			clear
			hora=$(date | cut -d " " -f5)
			cont=0
			while [ $cont -lt 20 ];do
				echo ""
				cont=$(($cont+1))
			done
			figlet -r $hora
			sleep 1
			read -s -t 0.1 -n 1 salir
			if [ -z $salir ];then
				salir="a"
			elif [ $salir = z ];then
				sleep 0.3
				echo "Saliendo..."
				sleep 1
				break
			fi
		done
		stty echo
		break
		;;
		c)
		stty -echo
		hora=0
		min=0
		seg=0
		echo "Pulsa c para pausar/comenzar y z para salir"
		figlet -r $hora:$min:$seg
		read -s -n 1 salir
		clear
		if [ -z $salir ];then
			salir="a"
		elif [ $salir = c ];then
			salir=a
			while true;do
				read -s -t 0.1 -n 1 salir
				if [ -z $salir ];then
					salir="a"
				elif [ $salir = c ];then
					figlet -r $hora:$min:$seg
					read -s -n 1 salir
					if [ $salir = z ];then
						sleep 0.3
						echo "Saliendo..."
						sleep 1
						break
					else
						salir=a
					fi
				elif [ $salir = z ];then
					sleep 0.3
					echo "Saliendo..."
					sleep 1
					break
				fi
				seg=$(($seg+1))
				if [ $seg -ge 60 ];then
					seg=0
					min=$(($min+1))
				fi
				if [ $min -ge 60 ];then
					min=0
					hora=$(($hora+1))
				fi
				figlet -r $hora:$min:$seg
				sleep 0.9
				clear
			done
		elif [ $salir = z ];then
			sleep 0.3
			echo "Saliendo..."
			sleep 1
			break
		fi
		stty echo
		break
		;;
		t)
		fin=a
		hora=0
		min=0
		seg=0
		while [ $fin != t ];do
			echo -e "\e[33m$hora\e[0m:$min:$seg"
			read -s -n 1 fin
			if [ -z $fin ];then
				fin=a
			elif [ $fin = w ];then
				hora=$(($hora+1))
				if [ $hora -gt 24 ];then
					hora=0
				fi
			elif [ $fin = s ];then
				hora=$(($hora-1))
				if [ $hora -lt 0 ];then
					hora=24
				fi
			fi
			clear
		done
		fin=a
		while [ $fin != t ];do
			echo -e "$hora:\e[33m$min\e[0m:$seg"
			read -s -n 1 fin
			if [ -z $fin ];then
				fin=a
			elif [ $fin = w ];then
				min=$(($min+1))
				if [ $min -gt 59 ];then
					min=0
				fi
			elif [ $fin = s ];then
				min=$(($min-1))
				if [ $min -lt 0 ];then
					min=59
				fi
			fi
			clear
		done
		fin=a
		while [ $fin != t ];do
			echo -e "$hora:$min:\e[33m$seg\e[0m"
			read -s -n 1 fin
			if [ -z $fin ];then
				fin=a
			elif [ $fin = w ];then
				seg=$(($seg+1))
				if [ $seg -gt 59 ];then
					seg=0
				fi
			elif [ $fin = s ];then
				seg=$(($seg-1))
				if [ $seg -lt 0 ];then
					seg=59
				fi
			fi
			clear
		done
		stty -echo
		echo "Pulsa c para pausar/comenzar y z para salir"
		read -s -n 1 salir
		clear
		if [ -z $salir ];then
			salir="a"
		elif [ $salir = c ];then
			salir=a
			while true;do
				read -s -t 0.1 -n 1 salir
				if [ -z $salir ];then
					salir="a"
				elif [ $salir = c ];then
					figlet -r $hora:$min:$seg
					read -s -n 1 salir
					if [ $salir = z ];then
						sleep 0.3
						echo "Saliendo..."
						sleep 1
						break
					else
						salir=a
					fi
				elif [ $salir = z ];then
					sleep 0.3
					echo "Saliendo..."
					sleep 1
					break
				fi
				seg=$(($seg-1))
				if [ $seg -lt 0 ];then
					seg=59
					min=$(($min-1))
				fi
				if [ $min -lt 0 ];then
					min=59
					hora=$(($hora-1))
					if [ $hora -lt 0 ];then
						hora=0
					fi
				fi
				figlet -r $hora:$min:$seg
				sleep 0.9
				clear
				if [ $hora -eq 0 ] && [ $min -eq 0 ] && [ $seg -eq 0 ];then
					figlet -r FIIIIN
					sleep 3
					break
				fi
			done
		elif [ $salir = z ];then
			sleep 0.3
			echo "Saliendo..."
			sleep 1
			break
		fi
		stty echo
		break
	esac
done

stty echo
fvaca ADIOS
