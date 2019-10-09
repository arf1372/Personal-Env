#!/bin/sh

INV_SPLIT="./../iptools/inverse_split.sh"

MWNETBLOCKS="$(./mwipextractor.py )"

for NETBLOCK in $MWNETBLOCKS
do
	echo "split $NETBLOCK"
	$INV_SPLIT "$NETBLOCK"
done
