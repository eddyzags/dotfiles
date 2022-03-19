#!/bin/env bash

# Description: A script to shutdown computer
# Maintainer: zagabe.ed@gmail.com

DM_LOGOUT_ACTIONS=(
    "shutdown"
)

action=$(printf '%s\n' "${DM_LOGOUT_ACTIONS[@]}" | dmenu -i -l 20 -p 'Shutdown menu:')

case $action in
    "shutdown")
        if [[ "$(echo -e "No\nYes" | dmenu -i -l 2 -p "${action}?" "${@}" )" == "Yes" ]]; then
            systemctl poweroff
        else
                echo "Aborting computer shutdown." && exit 0
        fi
        ;;
esac
