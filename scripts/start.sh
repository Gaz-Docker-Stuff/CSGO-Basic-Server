#!/bin/sh
cd $HOME/csgo
csgo/srcds_run -game csgo -tickrate 128 -autoupdate -steam_dir $STEAM -steamcmd_script ~/scripts/csgo_ds $@