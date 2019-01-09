#!/usr/bin/env bash

echo "[*] Checking i3 installation..."
type i3 > /dev/null
if [[ $? -ne 0 ]]; then
    read -p "[-] i3 is missing, would you like to install it [y/n]? " choice
    if [[ $choice = "y" ]]; then
        sudo apt-get install i3 -y
        echo "[+] Done"
    else
        echo "[-] Aborting..."
        exit 1
    fi
    
else
    echo "  [+] OK"
fi

if [[ ! -d $HOME/.config/i3 ]]; then
    echo "[*] Running i3-config-wizard..."
    i3-config-wizard
    echo "  [+] Done"  
fi

echo
echo "[*] Setting up fonts..."
if [[ ! -d $HOME/.fonts ]]; then
    mkdir $HOME/.fonts
fi

echo
cp fontawesome-webfont.ttf $HOME/.fonts
echo "  [+] Done"

echo
echo "[*] Moving config to $HOME/.config/i3/config..."
cp config $HOME/.config/i3/config
echo "  [+] Done"

echo
echo "[*] Moving i3status.conf to /etc/i3status.conf..."
sudo cp i3status.conf /etc/
echo "  [+] Done"

exit 0
