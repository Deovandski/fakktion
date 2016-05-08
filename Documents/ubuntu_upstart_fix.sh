#!/bin/bash
# Fixes UPSTART on latest Ubuntu Server releases.
sudo apt-get install upstart-sysv
sudo dpkg-divert --local --rename --remove /sbin/initctl
sudo ln -s /sbin/initctl.distrib /sbin/initctl
