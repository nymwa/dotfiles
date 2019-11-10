export DISPLAY=:0.0
for i in $(xinput | grep Keyboard | grep -oP "(?<==)[0-9]*"); do
	xinput enable $i;
done
for i in $(xinput | grep gpio | grep -oP "(?<==)[0-9]*"); do
	xinput enable $i;
done
xinput enable "Asus TouchPad"
xinput enable "SIS0457:00 0457:1133"
xinput enable "Intel HID events"
