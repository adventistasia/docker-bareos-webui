FROM       ssdit/bareos-base:16.2
MAINTAINER Ryann Micua <rmicua@ssd.org>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y bareos-webui

RUN sed -i "s/diraddress = \"localhost\"/diraddress = \"director\"/" /etc/bareos-webui/directors.ini
RUN tar cfvz /etc.tgz /etc/bareos-webui

ADD run.sh /run.sh
RUN chmod u+x /run.sh

EXPOSE 80

VOLUME /etc/bareos-webui

ENTRYPOINT ["/run.sh"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
