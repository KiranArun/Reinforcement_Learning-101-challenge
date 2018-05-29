#!/usr/bin/env bash

kill $(ps ax | grep websockify | grep -v grep | awk '{ print $1 }')
pkill ngrok
pkill vncserver
pkill Xvnc
pkill Xvfb
ps aux | egrep "ngrok|vnc"
