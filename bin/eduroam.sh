#!/bin/env bash

nmcli con add type wifi con-name "eduroam" ssid "eduroam" \
  ifname "interface name" \
  ipv4.method auto \
  802-1x.eap "peap" \
  802-1x.phase2-auth "mschapv2" \
  802-1x.identity "<numero-usp>@usp.br" \
  802-1x.password "senha do jupiter" \
  wifi-sec.key-mgmt "wpa-eap"

nmcli connection up eduroam
