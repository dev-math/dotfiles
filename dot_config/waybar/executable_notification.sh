#!/usr/bin/env bash

if [ "$(dunstctl is-paused)" = "true" ]
then
    echo 
elif [ "$(dunstctl is-paused)" = "false" ]
then
    echo 
fi
