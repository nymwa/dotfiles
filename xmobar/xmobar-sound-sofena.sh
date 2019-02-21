STAT=$(amixer -c 0 get Master | grep -oP "\[on\]|\[off\]")

if [ $STAT == "[off]" ]; then
	echo "M";
else
	amixer -c 0 get Master | grep -oP "[0-9]*(?=%)"
fi
