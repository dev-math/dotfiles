#!/bin/env bash

nmcli con add type wifi con-name "eduroam" ssid "eduroam" \
  ifname "wlp4s0" \
  ipv4.method auto \
  802-1x.eap "peap" \
  802-1x.phase2-auth "mschapv2" \
  802-1x.identity "numusp@usp.br" \
  802-1x.password "" \
  wifi-sec.key-mgmt "wpa-eap"

nmcli connection up eduroam
