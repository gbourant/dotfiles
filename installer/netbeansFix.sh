#mkdir -p /home/gbourant/.netbeans/8.2/etc
cp /usr/share/netbeans/etc/netbeans.conf /home/gbourant/.netbeans/8.2/etc/
netbeans_default_options=$(grep 'netbeans_default_options' /home/gbourant/.netbeans/8.2/etc/netbeans.conf)
netbeans_default_options=${netbeans_default_options: :-1}' -J-Dswing.aatext=TRUE -J-Dawt.useSystemAAFontSettings=on"'
sed -i "/netbeans_default_options/ { c \
$netbeans_default_options
}" /home/gbourant/.netbeans/8.2/etc/netbeans.conf