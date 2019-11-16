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

two () {
	if [ $1 -ge 100 ]; then
		echo 'FF'
	else
		printf '%02d' $1
	fi
}

MEMO=`free | grep Mem  | awk '{print int(($2-$7)/$2*100+0.5)}'`
SWAP=`free | grep Swap | awk '{print int($3/$2*100+0.5)}'`

printf '<fc=%s>%s</fc> <fc=%s>%s</fc>' `color $MEMO` `two $MEMO` `color $SWAP` `two $SWAP`

