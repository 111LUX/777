#!/bin/sh

case $@ in
	up) VOL="$(amixer sset Master 7%+ unmute | grep -Po "[0-9]+(?=%)" | head -1)" ;;
	down) VOL="$(amixer sset Master 7%- unmute | grep -Po "[0-9]+(?=%)" | head -1)" ;;
esac

echo "Vol $VOL%" | dzen2 -p 1 -bg gray4 -fg white -fn -14:Bold -h 30
