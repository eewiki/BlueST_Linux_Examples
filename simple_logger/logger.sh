#!/bin/bash

if ! id | grep -q root; then
	echo "must be run as root"
	exit
fi

while :
do
	date_stamp=$(date +%Y.%m.%d.%H.%M.%S)
	python3 grab_accel.py >> /var/www/html/accel-${date_stamp}.log
	sync
	if [ -f /tmp/stop ] ; then
		exit
	fi
	cat /var/www/html/accel-${date_stamp}.log | grep "^#Device BAI_400 disconnected unexpectedly." && sleep 5
	cat /var/www/html/accel-${date_stamp}.log | grep "^#No Bluetooth devices found. Exiting..." && exit
done

