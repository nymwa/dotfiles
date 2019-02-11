#!/bin/zsh
MOFU="≡╹ω╹≡"
NUM=1

while [ true ]
do
	clear
	for i in $(seq 1 $NUM);
	do
		echo $MOFU
	done
	NUM=$(expr $NUM + 1)
	sleep 1
done
