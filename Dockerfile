FROM ubuntu:16.04 

RUN apt-get update && apt-get install -y apt-utils vim curl git wget

##install php7.1
RUN apt-get update && apt-get install -y language-pack-en-base && \
    locale-gen en_US.UTF-8 && \
    apt-get install -y software-properties-common && \
    LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php && \
    apt-get update

RUN apt-get -y install php7.1 php7.1-mysql php7.1-fpm \
    php7.1-curl php7.1-xml php7.1-mcrypt php7.1-json \
    php7.1-gd php7.1-mbstring php7.1-zip php7.1-pgsql php7.1-bcmath

##install apache2
RUN apt-get install -y apache2 libapache2-mod-php7.1 && \
    a2enmod rewrite && \
    a2enmod php7.1 && \
    a2enmod alias

## install postgresql
RUN update-locale LANGUAGE="en_US.UTF-8" && \
    update-locale LANG="en_US.UTF-8" && \
    update-locale LC_ALL="en_US.UTF-8" && \
    apt-get install -y postgresql postgresql-contrib

##install composer global
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
EXPOSE 80
EXPOSE 5432

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
