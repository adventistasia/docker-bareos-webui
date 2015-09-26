FROM       ubuntu:trusty
MAINTAINER Kai Wembacher <kai@ktwe.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y wget

RUN bash -c 'echo "deb http://download.bareos.org/bareos/release/15.2/xUbuntu_14.04/ /" > /etc/apt/sources.list.d/bareos.list'
RUN bash -c 'wget -q http://download.bareos.org/bareos/release/15.2/xUbuntu_14.04/Release.key -O- | apt-key add -'

RUN bash -c "echo 'postfix postfix/main_mailer_type select No configuration' | debconf-set-selections"

RUN apt-get update && apt-get install -y bareos-webui

RUN sed -i "s/diraddress = \"localhost\"/diraddress = \"director\"/" /etc/bareos-webui/directors.ini
RUN tar cfvz /etc.tgz /etc/bareos-webui

ADD run.sh /run.sh
RUN chmod u+x /run.sh

EXPOSE 80

VOLUME /etc/bareos-webui

ENTRYPOINT ["/run.sh"]
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]