
FROM debian:wheezy
MAINTAINER Haris Lihovac <hlihovac@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

ADD etc/timezone /etc/timezone
ADD etc/apt /etc/apt

RUN apt-get update && \
	apt-get upgrade -y && \
        apt-get install -yq ca-certificates inotify-tools nano pwgen supervisor unzip wget cron && \
	apt-get clean && \
	echo -n > /var/lib/apt/extended_states

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABF5BD827BD9BF62 && \
	echo "deb http://nginx.org/packages/mainline/debian/ wheezy nginx" > /etc/apt/sources.list.d/nginx.list && \
	apt-get update && \
	apt-get install -yq nginx=1.9.7-1~wheezy && \
	apt-get clean

RUN rm -rf /etc/nginx/*.d && \
	mkdir -p /etc/nginx/addon.d /etc/nginx/conf.d /etc/nginx/host.d /etc/nginx/nginx.d

## for php above 54 add this repo before install
## RUN echo "deb http://packages.dotdeb.org/ wheezy-php56 all" > /etc/apt/sources.list.d/php.list && \
##	apt-get update && \

#RUN apt-get update && \
RUN apt-get install -yq php5-cli php5-curl php5-fpm php5-gd php5-imap php5-mcrypt php5-mysql php5-pgsql

RUN rm -rf /etc/nginx/*.d /etc/php5/fpm/pool.d && \
        mkdir -p /etc/nginx/addon.d /etc/nginx/conf.d /etc/nginx/host.d /etc/nginx/nginx.d /etc/php5/fpm/pool.d

ADD etc/nginx /etc/nginx
ADD etc/php5 /etc/php5

RUN useradd -u 500 core

RUN mkdir /config /data
ADD config /config
RUN chmod +x /config/loop

EXPOSE 80 443
ADD supervisord.conf /etc/supervisor/conf.d/nginx.conf
ADD vtiger.cron /etc/cron.d/vtiger

CMD /config/loop

