#!/usr/bin/env bash
set -e -u

systemctl enable NetworkManager
systemctl enable lightdm

sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "andaos-live" > /etc/hostname
ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# CREATE the nopasswdlogin group FIRST
groupadd -r nopasswdlogin

# NOW create live user and add to groups
useradd -m -G wheel,nopasswdlogin -s /bin/bash live
passwd -d live

# root
passwd -d root

# LightDM autologin
mkdir -p /etc/lightdm/lightdm.conf.d
cat > /etc/lightdm/lightdm.conf.d/10-autologin.conf <<INNER_EOF
[Seat:*]
autologin-user=live
autologin-user-timeout=0
autologin-session=xfce
INNER_EOF

# fix PAM
mkdir -p /etc/pam.d
cat > /etc/pam.d/lightdm-autologin <<INNER_EOF
#%PAM-1.0
auth        sufficient  pam_succeed_if.so user ingroup nopasswdlogin
auth        required    pam_permit.so
account     include     system-login
password    include     system-login
session     include     system-login
INNER_EOF

echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

# Set Anda OS branding
cat > /etc/os-release <<INNER_EOF
NAME="Anda OS"
PRETTY_NAME="Anda OS"
ID=andaos
ID_LIKE=arch
BUILD_ID=rolling
ANSI_COLOR="38;2;23;147;209"
HOME_URL="https://andaos.local/"
LOGO=andaos
INNER_EOF

cat > /etc/lsb-release <<INNER_EOF
DISTRIB_ID="AndaOS"
DISTRIB_RELEASE="rolling"
DISTRIB_DESCRIPTION="Anda OS"
INNER_EOF

# Set wallpaper permissions
chmod 644 /usr/share/backgrounds/andaos/default.png 2>/dev/null || true
