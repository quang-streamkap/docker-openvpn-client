#!/bin/bash
# Start the D-Bus daemon
dbus-daemon --system --nofork &

# Wait a bit to ensure D-Bus has started
sleep 2

# Start OpenVPN
/usr/sbin/openvpn3-autoload --directory /etc/openvpn3/autoload
