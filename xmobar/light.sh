#!/bin/bash

color () {
	if   [ $1 -lt 20 ]; then echo '#777700';
	elif [ $1 -lt 40 ]; then echo '#999900';
	elif [ $1 -lt 60 ]; then echo '#BBBB00';
	elif [ $1 -lt 80 ]; then echo '#DDDD00';
	else                     echo '#FFFF00';
	fi
}

two () {
	if [ $1 -ge 100 ]; then
		echo 'FF'
	else
		printf '%02d' $1
	fi
}

LIGHT=`light -G | awk '{print int($0)}'`

printf '<fc=%s>%s</fc>' `color $LIGHT` `two $LIGHT`

