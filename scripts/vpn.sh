#!/bin/env bash

# i3status script to dispay the vpn client status.

IFS=!
ARRAY=`ls /etc/openvpn/client`

for i in ${ARRAY[*]}; do
    systemctl status openvpn-client@${i/.conf} | grep running > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "VPN: ${i/.conf}"
        exit 0
    fi
done

echo "VPN: no"
exit 0
