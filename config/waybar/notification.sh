#!/bin/env bash

if [ "$(dunstctl is-paused)" = "true" ]
then
  echo 
elif [ "$(dunstctl is-paused)" = "false" ]
then
  echo 
fi

pkill -RTMIN+8 waybar
