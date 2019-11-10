export DISPLAY=:0.0
for i in $(xinput | grep Keyboard | grep -oP "(?<==)[0-9]*"); do
	xinput disable $i;
done
for i in $(xinput | grep gpio | grep -oP "(?<==)[0-9]*"); do
	xinput disable $i;
done
xinput disable "Asus TouchPad"
xinput disable "SIS0457:00 0457:1133"
xinput disable "Intel HID events"
