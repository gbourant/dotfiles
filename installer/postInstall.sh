#Installing programs
#archlinux-java

function change_owner {
    echo "chaning ownership -> $1"
    chown gbourant $1
    chgrp gbourant $1
}




pacman -S --needed --noconfirm git feh perl-anyevent-i3 numlockx
pacman -S --needed --noconfirm udisks2 gvfs
pacman -S --needed --noconfirm rxvt-unicode i3 dmenu xorg \
                      xorg-xinit  rofi lxappearance arandr \
                      sudo pavucontrol compton playerctl xclip

pacman -S --needed --noconfirm jdk8-openjdk openssh neovim yaourt netbeans keepassxc libreoffice-still maven nodejs npm deluge docker virtualbox speedcrunch evolution p7zip tumbler pulseaudio evince vlc qt4 rclone
#pacman -S --noconfirm git firefox
#xterm #feh
pacman -S --needed --noconfirm thunar  arc-gtk-theme curl zsh
pacman -S --needed --noconfirm  ttf-dejavu

pacman -S --needed --noconfirm ttf-font-awesome alsa-utils
pacman -S --needed --noconfirm imagemagick scrot




#bittorrent#transmission-gtk
#yaourt -S --noconfirm oh-my-zsh-git

#runuser -s /bin/bash -l gbourant -c "yaourt -S rxvt-unicode-patched paper-gtk-theme-git paper-icon-theme-git"

#masterpdfeditor

#export PATH=$PATH:/opt/apache-maven/bin
#/usr/share/applications/nvim.desktop


runuser -s /bin/bash -l gbourant -c "git clone https://github.com/powerline/fonts.git --depth=1 ~/fonts"
#runuser -s /bin/bash -l gbourant -c "~/fonts/install.sh"
runuser -s /bin/bash -l gbourant -c "mkdir -p ~/.local/share/fonts"
runuser -s /bin/bash -l gbourant -c "cp ~/fonts/RobotoMono/* ~/.local/share/fonts"
#runuser -s /bin/bash -l gbourant -c "cp ~/fonts/* ~/.local/share/fonts"
runuser -s /bin/bash -l gbourant -c "rm -rf ~/fonts"
runuser -s /bin/bash -l gbourant -c "fc-cache"
runuser -s /bin/bash -l gbourant -c "curl -O https://raw.githubusercontent.com/bookercodes/dotfiles/arch/.Xresources"
runuser -s /bin/bash -l gbourant -c "curl -O https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"
runuser -s /bin/bash -l gbourant -c "sed -i 's/env zsh//g' install.sh"
runuser -s /bin/bash -l gbourant -c "sed -i 's/env//g' install.sh"
runuser -s /bin/bash -l gbourant -c "sed -i 's/URxvt.font: xft:hack:size=14/URxvt.font: xft:Roboto Mono for Powerline:size=14/g' .Xresources"
runuser -s /bin/bash -l gbourant -c "echo 'URxvt.letterSpace: 1' >> .Xresources"
runuser -s /bin/bash -l gbourant -c "chmod +x install.sh"
runuser -s /bin/bash -l gbourant -c "./install.sh"

runuser -s /bin/bash -l gbourant -c 'git config --global user.email "gbourant@gmail.com"'
runuser -s /bin/bash -l gbourant -c 'git config --global user.name "gbourant"'

runuser -s /bin/bash -l gbourant -c 'mkdir -p ~/Documents/Screenshots'


echo "NOCONFIRM=1" > /home/gbourant/.yaourtrc
echo "BUILD_NOCONFIRM=1" >> /home/gbourant/.yaourtrc
echo "EDITFILES=0" >> /home/gbourant/.yaourtrc
change_owner /home/gbourant/.yaourtrc
#jdownloader2
#libcurl-openssl-1.0
#gitg
runuser -s /bin/bash -l gbourant -c "yaourt -S --noconfirm google-chrome gscreenshot visual-studio-code-bin skypeforlinux-stable-bin gpicview-gtk3 git-cola"
runuser -s /bin/bash -l gbourant -c "yaourt -S --noconfirm paper-gtk-theme-git paper-icon-theme-git"
#runuser -s /bin/bash -l gbourant -c "git clone https://github.com/gbourant/dotfiles.git ~/.dotfiles"
runuser -s /bin/bash -l gbourant -c "~/.dotfiles/rice.sh"

#ttf-roboto-mono rxvt-unicode-patched

#--needed
echo "#!/bin/zsh" > /home/gbourant/.xinitrc
#echo "export PATH=$PATH:/opt/maven/bin" >> /home/gbourant/.xinitrc
echo "xrdb -merge ~/.Xresources &" >> /home/gbourant/.xinitrc
echo "numlockx &" >> /home/gbourant/.xinitrc
echo "exec i3" >> /home/gbourant/.xinitrc

change_owner /home/gbourant/.xinitrc

echo 'if [[ "$(tty)" == '/dev/tty1' ]];then' >> /etc/zsh/zprofile
echo "setopt autolist" >> /etc/zsh/zprofile
echo "unsetopt menucomplete" >> /etc/zsh/zprofile
echo "exec startx" >> /etc/zsh/zprofile
echo "fi" >> /etc/zsh/zprofile