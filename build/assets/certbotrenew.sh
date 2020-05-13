renew () {
   certbot-auto renew --renew-hook "cp /etc/letsencrypt/live/tunnel.$DOMAIN/{cert,privkey}.pem /opt/openvpn-gui/cert" --renew-hook "pkill openvpn-web-ui"
}

while :
do
   sleep 2592000
   renew
done

