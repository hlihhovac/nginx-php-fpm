# nginx-php-fpm
debian [wheezy](https://wiki.debian.org/DebianWheezy) based docker image with nginx-1.9 and php-fpm-5.4 for [vTiger CRM v6.2](https://www.vtiger.com/open-source/) deployment

based on [maxexcloo/nginx-php](https://hub.docker.com/r/maxexcloo/nginx-php/) image concept
except pushed into one level Dockerfile instead of three level "inheritance" concept (debian->nginx->php) by maxexcloo
and inforced lock to php<5.5 as vTiger requirement

for data structure explanation see [maxexcloo/nginx-php:README.md](https://github.com/maxexcloo/Docker/blob/master/README.md).
/etc and /config contains config files tunned for vTiger hosting

for image build use

    git clone https://github.com/hlihhovac/nginx-php-fpm.git

then modify configs in /etc and /config as required

build image: 

    sudo docker build -t local/nginx-php-fpm .

run container with 

    sudo docker run -it \
    --link mysql-1:mysql \
    -v /opt/docker-shared/vtiger1-data/etc/php-vtiger.conf:/data/config/php-vtiger.conf \
    -v /opt/docker-shared/vtiger1-data/vtigercrm:/data/http \
    limes.ba/nginx-php-fpm 
