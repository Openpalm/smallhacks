killall NetworkManager
sleep 1
echo 0 > /sys/fs/selinux/enforce
sleep 1
wpa_supplicant -i wlp2s0b1 -c /etc/wpa_supplicant/wpa_supplicant.conf &
sleep 2
dhclient
sleep 1
echo done
echo 1 > /sys/fs/selinux/enforce

