#!/bin/bash

para=$(grep '^NAME=' /etc/os-release)
len=${#para}
name=${para:6:len-7}
echo $name

if [ "$name" == "Arch Linux" ]
then
	sudo pacman -S xorg-xinput xf86-input-evdev python-evdev python-pyusb xdotool libnotify xorg-xrandr arandr python-numexpr
else
	sudo apt install xinput xserver-xorg-input-evdev python3-evdev python3-usb xdotool libnotify-bin arandr python3-numexpr
	sudo apt install make automake gcc pkg-config libusb-1.0-0-dev  # For ubuntu
fi

git clone https://github.com/DIGImend/uclogic-tools
cd uclogic-tools
autoreconf -i -f && ./configure --prefix=/usr/local/ && make
sudo make install


sudo sh -c 'printf "Section "InputClass"\n\tIdentifier "evdev tablet catchall"\n\tMatchIsTablet "on"\n\tMatchDevicePath "/dev/input/event*"\n\tDriver "evdev"\nEndSection\n" >> /etc/X11/xorg.conf.d/evdev-tablet.conf'  

#only applies if github wasn't cloned
#git clone https://github.com/TortugaAttack/huion-linux-drivers
#cd huion-linux-drivers/

