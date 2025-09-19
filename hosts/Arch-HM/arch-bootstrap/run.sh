#!/bin/bash

sudo pacman -Syu --needed ansible git python
ansible-galaxy collection install community.general

ansible-playbook -i inventory.ini site.yml
