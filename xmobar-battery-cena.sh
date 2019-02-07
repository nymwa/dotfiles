if [ $(cat /sys/class/power_supply/ADP1/online) -eq 1 ]; then
	CHARGE="+";
else
	CHARGE=" ";
fi

NUM=$(cat /sys/class/power_supply/BATC/capacity)

if [ $NUM -le 20 ]; then
	COLOR="red";
elif [ $NUM -le 50 ]; then 
	COLOR="yellow";
elif [ $NUM -le 80 ]; then 
	COLOR="green";
else
	COLOR="blue";
fi

echo "<fc=$COLOR>$NUM$CHARGE</fc>"
