#!/bin/bash

set -e
OVDIR=/etc/openvpn

cd /opt/

if [ ! -f $OVDIR/.provisioned ]; then
  echo "Preparing certificates"
  mkdir -p $OVDIR
  ./scripts/generate_ca_and_server_certs.sh
  openssl dhparam -dsaparam -out $OVDIR/dh2048.pem 2048
  touch $OVDIR/.provisioned
  mkdir /opt/openvpn-gui/cert
  openssl req -new -x509 -days 365 -nodes -out /opt/openvpn-gui/cert/cert.pem -keyout /opt/openvpn-gui/cert/privkey.pem -subj "/C=CA/ST=Quebec/L=Mirabel/O=IT/CN=www.likuid.com"
fi

if [ ! -f /etc/letsencrypt/live/tunnel.$DOMAIN/cert.pem ]; then
  ./scripts/certbotrequest.sh &
else
  ./scripts/certbotrenew.sh &
fi

cd /opt/openvpn-gui
mkdir -p db
./openvpn-web-ui
echo "Starting!"

