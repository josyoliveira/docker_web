FROM ubuntu:14.04

LABEL maintainer "Joseane Oliveira"

RUN apt update && apt install -y apache2 php5 libapache2-mod-php5 && apt-get clean
EXPOSE 80 443
COPY ./index.html /var/www/html/index.html
RUN mkdir /var/www/html/php
RUN mkdir /etc/apache2/ssl/
COPY ./index.php /var/www/html/php/index.php
COPY ./admweb.key /etc/apache2/ssl/admweb.key
COPY ./admweb.crt /etc/apache2/ssl/admweb.pem
COPY ./admweb.conf /etc/apache2/sites-available/default-ssl.conf
RUN a2enmod ssl
RUN a2ensite default-ssl
CMD /usr/sbin/apache2ctl -D FOREGROUND
