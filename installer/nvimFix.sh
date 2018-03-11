sed -i "s/Exec=nvim %F/\/usr\/bin\/urxvt -e nvim/g" /usr/share/applications/nvim.desktop
sed -i "s/Terminal=true/Terminal=false/g" /usr/share/applications/nvim.desktop
