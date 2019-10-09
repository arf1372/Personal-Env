#!/bin/sh

GATEWAY=$(ip route show default | sed -nre s"/.*via (.*) dev .*/\1/p" | head -n 1 )
IFACE=$(ip route get $GATEWAY | sed -nre s"/.* dev ([[:alnum:]]*) .*/\1/p" )
SIP=$(ip addr show dev $IFACE | grep 'inet ' | sed -re s"/^[[:space:]]*//" | cut -d ' ' -f 2 | sed -re s"/\/[[:digit:]]+$//" )

ip route add $1 via $GATEWAY dev $IFACE src $SIP
