#!/bin/bash

color () {
	if   [ $1 -lt 20 ]; then echo '#FF3333';
	elif [ $1 -lt 30 ]; then echo '#11FF55';
	elif [ $1 -lt 50 ]; then echo '#FFFF00';
	elif [ $1 -lt 70 ]; then echo '#66CCFF';
	elif [ $1 -lt 80 ]; then echo '#FF00FF';
	else                     echo '#00FFFF';
	fi
}

charge () {
	if [ $(cat /sys/class/power_supply/ADP1/online) -eq 1 ]; then
		echo +
	else
		echo -
	fi
}

two () {
	if [ $1 -ge 100 ]; then
		echo 'FF'
	else
		printf '%02d' $1
	fi
}

NUM=$(cat /sys/class/power_supply/BAT1/capacity)
printf '<fc=%s>%s%s</fc>' `color $NUM` `two $NUM` `charge $NUM`

