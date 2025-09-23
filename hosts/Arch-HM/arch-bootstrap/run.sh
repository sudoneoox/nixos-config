#!/bin/bash

sudo pacman -Syu --needed ansible git python
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
ansible-galaxy collection install community.general
ansible-playbook -i inventory.ini site.yml -K

# Install lix using their provided helper script
curl --proto '=https' --tlsv1.2 -sSf -L https://install.lix.systems/lix -o lix-install.sh && chmod +x lix-install.sh && ./lix.install.sh
