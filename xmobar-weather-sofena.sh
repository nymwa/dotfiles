curl -s "wttr.in/HND?format=1" | awk '{print "<fn=2>"$1"</fn> "$2}'
