#!/bin/bash
## In The Name of Allah

TMPFILE="$(mktemp)"

cat <<EOF > $TMPFILE
# Update system to most recent version of packages
apt update
apt full-upgrade -yf

# Install desktop essential packages
apt install -yf vlc ubuntu-restricted-{extras,addons} clementine ffmpeg

# Install essential tools for developers
# C/C++ tools
apt install build-essential cmake g{cc,++}-multilib llvm clang clang-tidy
# Python tools
apt install -yf python3 python3-pip
#pip install --upgrade pip
#pip install --upgrade numpy matplotlib ipython jupyter

# VPMs
apt install {,network-manager-}open{connect,vpn}
for i in nm-open{connect,vpn} openvpn
do
	usermod $USER -a -G $i
done

# Digital art
apt install ubuntustudio-graphics

# Audio editing
#apt install ubuntustudio-audio
EOF

chmod +x $TMPFILE

sudo $TMPFILE

rm -f $TMPFILE
