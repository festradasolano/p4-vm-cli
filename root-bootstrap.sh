#!/bin/bash

# Print commands and exit on errors
set -xe

# Update package lists
apt-get update

# Install packages
KERNEL=$(uname -r)
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --fix-missing\
  autoconf \
  automake \
  bison \
  build-essential \
  ca-certificates \
  cmake \
  cpp \
  curl \
  doxygen \
  flex \
  git \
  libboost-dev \
  libboost-filesystem-dev \
  libboost-iostreams1.58-dev \
  libboost-program-options-dev \
  libboost-system-dev \
  libboost-test-dev \
  libboost-thread-dev \
  libc6-dev \
  libevent-dev \
  libffi-dev \
  libfl-dev \
  libgc-dev \
  libgc1c2 \
  libgflags-dev \
  libgmp-dev \
  libgmp10 \
  libgmpxx4ldbl \
  libjudy-dev \
  libpcap-dev \
  libreadline6 \
  libreadline6-dev  \
  libssl-dev \
  libtool \
  linux-headers-$KERNEL\
  make \
  mktemp \
  pkg-config \
  python \
  python-dev \
  python-ipaddr \
  python-pip \
  python-psutil \
  python-scapy \
  python-setuptools \
  tcpdump \
  unzip \
  vim \
  wireshark \
  wget \
  xterm

# Add p4 user
useradd -m -d /home/p4 -s /bin/bash p4
echo "p4:p4" | chpasswd
echo "p4 ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/99_p4
chmod 440 /etc/sudoers.d/99_p4
usermod -aG vboxsf p4

# Allow SSH password authentication
sed -i 's/PasswordAuthentication/#PasswordAuthentication/g' /etc/ssh/sshd_config

# Configure network interfaces
mv /etc/network/interfaces /etc/network/interfaces.bak
echo "auto lo" >> /etc/network/interfaces
echo "iface lo inet loopback" /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "auto enp0s3" >> /etc/network/interfaces
echo "iface enp0s3 inet dhcp" >> /etc/network/interfaces
echo "" >> /etc/network/interfaces
echo "auto enp0s8" >> /etc/network/interfaces
echo "iface enp0s8 inet dhcp" >> /etc/network/interfaces
/etc/init.d/networking restart

# Automatically log into the P4 user
# TODO
