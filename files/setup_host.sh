#!/bin/bash

# Custom minimal setup for minimal Fedora 30
# Note use special created USB drives with specific files and key
# Project: Triado  - Nationaal Archief
# (2019) MTO

install_wifi () {
    rpm -Uvh rpm/iwl7260-firmware-25.30.13.8-99.fc30.noarch.rpm
    rpm -Uvh rpm/wpa_supplicant-2.7-5.fc30.x86_64.rpm
    rpm -Uvh rpm/NetworkManager-wifi-1.16.0-1.fc30.x86_64.rpm
    echo 'Installed WiFi fc30\r\n'
}

install_firmware () {
    rpm -Uvh rpm/linux-firmware-20190717-99.fc30.noarch.rpm
    echo 'Installed Firmware fc30\r\n'
}

install_gnome_minimal () {
    dnf install @basex gnome-shell
    dnf install gnome-terminal dejavu-sans-mono-fonts bash-completion
    systemctl set-default graphical.target
    systemctl isolate graphical.target
    echo 'Installed GNOME minimal fc30\r\n' 
}

install_software_utilities () {
    dnf install net-tools bind-utils vim unzip mlocate eog tree 
    #dnf install NetworkManager-openvpn NetworkManager-bluetooth
    #dnf install git whois traceroute
}

install_software_programs () {
    # Firefox
    #dnf install firefox
    # Chrome
    dnf install fedora-workstation-repositories
    dnf config-manager --set-enabled google-chrome
    dnf install google-chrome-stable
    # Docker
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    dnf makecache
    sudo dnf install docker-ce
    systemctl enable docker.service
    systemctl start docker.service
    # ThunderBird
    #dnf install thunderbird
}

configure_wifi () {
    local ssid=$1
    nmcli dev wifi rescan
    nmcli dev wifi connect $ssid --ask
    echo 'Configured WiFi $ssid fc30\r\n' 
}

configure_crypt () {
   local luks_device=$1 
   \cp config/crypt/luks-secret.key /root/ 
   cryptsetup luksDump $luks_device
   cryptsetup luksAddKey $lusk_device /root/luks-secret.key --key-slot 1
   cryptsetup luksDump $luks_device
   shred --remove --zero /root/luks-secret.key
   \cp config/crypt/cryptroot-ask.sh /usr/lib/dracut/modules.d/90crypt/
   \cp config/crypt/module-setup.sh /usr/lib/dracut/modules.d/90crypt/ 
   \cp config/crypt/usb-decrypt.sh /etc/dracut.conf.d/
   dracut -f
   exit 0
   echo 'Configured Crypt config fc30\r\n'
}

configure_grub () {
    \cp config/grub/grub /etc/default/grub
    grub2-mkconfig -o /boot/grub2/grub.cfg
    echo 'Configured Grub fc30\r\n'
}

configure_startup_script () {
    \cp config/script/setenv /usr/local/sbin/
    \cp config/script/rc.local /etc/rc.d/
    systemctl enable rc-local.service
    systemctl start rc-local.service
    echo 'Configured setenv.sh with rc-local.service'
}

update_system () {
    dnf update
}

install_wifi
install_firmware

configure_wifi ""
configure_crypt ""
configure_grub

install_gnome_minimal
install_software_utilities 
#update_system