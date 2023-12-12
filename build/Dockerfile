# FROM alpine:3.17

# RUN apk add --no-cache \
#     bash \
#     bind-tools \
#     iptables \
#     ip6tables \
#     openvpn

# COPY . /usr/local/bin

# ENV KILL_SWITCH=on

# ENTRYPOINT [ "entry.sh" ]


# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Add the OpenVPN Apt signing key
RUN apt-key adv --fetch-keys https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub

# Add the OpenVPN repository
RUN echo "deb https://swupdate.openvpn.net/community/openvpn3/repos focal main" > /etc/apt/sources.list.d/openvpn3.list

# Install OpenVPN
RUN apt-get update && apt-get install -y openvpn3

# Create config directory
RUN mkdir -p /etc/openvpn3/autoload

COPY ./config /etc/openvpn3/autoload

RUN chmod -R 755 /etc/openvpn3/autoload

# # # Start dbus
# RUN dbus-uuidgen > /var/lib/dbus/machine-id
# RUN mkdir -p /var/run/dbus
# RUN dbus-daemon --config-file=/usr/share/dbus-1/system.conf --print-address

# Copy the start script
COPY start-openvpn.sh /usr/local/bin/start-openvpn.sh
RUN chmod +x /usr/local/bin/start-openvpn.sh

# # Copy necessary files to /usr/local/bin
# COPY . /usr/local/bin

# # Set environment variable for kill switch
# ENV KILL_SWITCH=on

# Set the command to start OpenVPN 3 Linux configuration auto-loader
# CMD ["/usr/sbin/openvpn3-autoload", "--directory", "/etc/openvpn3/autoload"]

ENTRYPOINT ["tail", "-f", "/dev/null"]