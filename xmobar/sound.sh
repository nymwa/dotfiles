#!/bin/bash

color () {
	if   [ $1 -lt 20 ]; then echo '#00FFFF';
	elif [ $1 -lt 30 ]; then echo '#FF00FF';
	elif [ $1 -lt 50 ]; then echo '#66CCFF';
	elif [ $1 -lt 70 ]; then echo '#FFFF00';
	elif [ $1 -lt 80 ]; then echo '#11FF55';
	else                     echo '#FF3333';
	fi
}

VOL=`pamixer --get-volume`
pamixer --get-mute > /dev/null
MUTE=$?
if [ $MUTE -eq 0 ]; then
	printf '<fc=red>MM</fc>'
elif [ $VOL -eq 100 ]; then
	printf '<fc=%s>FF</fc>' `color $VOL`
else
	printf '<fc=%s>%2d</fc>' `color $VOL` $VOL
fi

