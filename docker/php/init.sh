#!/bin/bash

set -e

apt-get update && apt-get install -y \
    build-essential \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    nano \
    unzip \
    git \
    curl \
    npm \
    iputils-ping \
    dnsutils \
    git \
    poppler-utils

#PDFtk  https://github.com/mikehaertl/php-pdftk
#https://qastack.mx/ubuntu/1028522/how-can-i-install-pdftk-in-ubuntu-18-04-and-later
#https://www.sitepoint.com/filling-pdf-forms-pdftk-php/
#cd /tmp
#wget http://mirrors.kernel.org/ubuntu/pool/universe/p/pdftk-java/pdftk-java_3.0.9-1_all.deb
#apt install -y -q ./pdftk-java_3.0.9-1_all.deb
#pdftk --version

#pdfsig

#sudo apt install git default-jdk-headless ant \
#    libcommons-lang3-java libbcprov-java
#cd /usr/local/bin
#git clone https://gitlab.com/pdftk-java/pdftk.git
#cd pdftk
#mkdir lib
#ln -st lib /usr/share/java/{commons-lang3,bcprov}.jar
#ant jar
#echo "alias pdftk='java -jar /usr/local/bin/pdftk/build/jar/pdftk.jar'" >> ~/.bashrc
#source ~/.bashrc

# Clear cache
#apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
docker-php-ext-install pdo_mysql zip exif pcntl
docker-php-ext-configure gd --with-freetype --with-jpeg

#RUN docker-php-ext-configure gd --enable-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
docker-php-ext-install gd

# Install composer
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#Uncomment permission fix and resolvers in case to be unable to resolve Debian repositories:

#chmod o+r /etc/resolv.conf
#echo "nameserver 8.8.8.8" >> /etc/resolv.conf 
#npm run dev
usermod -u 1000 www-data

composer install
php-fpm