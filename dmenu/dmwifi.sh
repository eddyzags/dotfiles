#!/usr/bin/env bash

# Name: dmwifi.sh
# Description: Connect to known wifi
# Maintainer: zagabe.ed@gmail.com

networkInterface="wlp2s0"
configs=`cat /etc/network/interfaces | grep "iface" | awk -F ' ' '{print $2}'`

targetedConfig=$(printf '%s\n' "${configs[@]}" "off" | sort | dmenu -i -l 20 -p 'Choose known WIFI:')

if [[ "$targetedConfig" == "off" ]]; then
    sudo ifdown "$networkInterface"
else
    sudo ifup $networkInterface=$targetedConfig
fi


