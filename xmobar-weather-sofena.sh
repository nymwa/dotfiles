echo $(curl -s "ja.wttr.in/hnd?0" | head -n 4 | tail -n 2 | sed -e "s/\[[0-9;]*m//g" | cut -c 16-)
