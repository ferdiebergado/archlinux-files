#!/bin/bash
wget -O /tmp/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
cat /tmp/hosts | grep '^0\.0\.0\.0' | awk '{print "local-zone: \""$2"\" redirect\nlocal-data: \""$2" A 0.0.0.0\""}' > /etc/unbound/adservers
systemctl restart unbound
