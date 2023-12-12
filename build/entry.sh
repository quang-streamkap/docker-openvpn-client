#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

cleanup() {
    kill TERM "$openvpn_pid"
    exit 0
}

is_enabled() {
    [[ ${1,,} =~ ^(true|t|yes|y|1|on|enable|enabled)$ ]]
}


openvpn_args=(
    "--config" "$CONFIG_FILE"
    "--cd" "/config"
)

if is_enabled "$KILL_SWITCH"; then
    openvpn_args+=("--route-up" "/usr/local/bin/killswitch.sh $ALLOWED_SUBNETS")
fi

openvpn_args+=("--auth-user-pass" "$AUTH_SECRET")

openvpn "${openvpn_args[@]}" &
openvpn_pid=$!

trap cleanup TERM

wait $openvpn_pid
