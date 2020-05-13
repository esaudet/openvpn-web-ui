request () {
   certbot-auto certonly --standalone --agree-tos -m admin@likuid.com -d tunnel.$DOMAIN
}

while :
do
   request
   if (( $? == 0 )) : then
      cp /etc/letsencrypt/live/tunnel.$DOMAIN/{cert,privkey}.pem /opt/openvpn-gui/cert
      reboot
   else
      sleep 3600
   fi
done

