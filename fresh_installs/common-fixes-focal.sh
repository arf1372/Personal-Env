#!/bin/bash
# In The Name of Allah

cat <<EOF | sudo tee /etc/apt/sources.list > /dev/null
deb http://archive.ubuntu.com/ubuntu/ focal main restricted multiverse universe
deb-src http://archive.ubuntu.com/ubuntu/ focal main restricted multiverse universe
deb http://security.ubuntu.com/ubuntu/ focal-security main restricted multiverse universe
deb-src http://security.ubuntu.com/ubuntu/ focal-security main restricted multiverse universe
deb http://archive.ubuntu.com/ubuntu/ focal-updates main restricted multiverse universe
deb-src http://archive.ubuntu.com/ubuntu/ focal-updates main restricted multiverse universe
deb http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb-src http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb http://archive.canonical.com/ubuntu focal partner
deb-src http://archive.canonical.com/ubuntu focal partner
EOF

echo ""
echo ""

cat <<EOF | sudo tee -a /etc/resolv.conf > /dev/null
nameserver 1.1.1.1
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF
