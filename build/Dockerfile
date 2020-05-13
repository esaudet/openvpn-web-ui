FROM debian:jessie
WORKDIR /opt
EXPOSE 8080

RUN apt-get update && apt-get install -y easy-rsa wget
RUN chmod 755 /usr/share/easy-rsa/*
ADD assets/start.sh /opt/start.sh
ADD assets/generate_ca_and_server_certs.sh /opt/scripts/generate_ca_and_server_certs.sh
ADD assets/vars.template /opt/scripts/
ADD assets/certbotrenew.sh /opt/scripts/
ADD assets/certbotrequest.sh /opt/scripts/

ADD openvpn-web-ui.tar.gz /opt/openvpn-gui/
RUN rm -f /opt/openvpn-gui/data.db
ADD assets/app.conf /opt/openvpn-gui/conf/app.conf

RUN wget -q https://dl.eff.org/certbot-auto -O /usr/local/bin/certbot-auto
RUN chmod 0755 /usr/local/bin/certbot-auto
RUN certbot-auto -q --install-only

CMD /opt/start.sh

