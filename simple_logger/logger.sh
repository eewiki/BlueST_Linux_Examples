#!/bin/bash

if ! id | grep -q root; then
	echo "must be run as root"
	exit
fi

python3 grab_accel.py | grep -v '#' >> /var/www/html/accel-$(date +%Y.%m.%d.%H.%M.%S).log

