# Base Ubuntu 12.04 Image
# Nginx, php5, composer, mysql
# outrunthewolf

# Base Docker File
FROM ubuntu:precise

# Maintainer
MAINTAINER outrunthewolf

# Check we've got the lastest distr
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list

# Update the box
RUN apt-get update

# Install any programs needed, including composer
RUN apt-get install -y git-core php5 php5-fpm php5-cgi php5-cli spawn-fcgi curl php5-curl php5-mcrypt nano htop openssh-server gcc libpcre3 libpcre3-dev libssl-dev make php5-mysql mysql-server
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer

# Download and install nginx
RUN cd /home && \
	mkdir downloads && \
	cd downloads && \
	wget http://nginx.org/download/nginx-1.4.1.tar.gz && \
	tar -zxvf nginx-1.4.1.tar.gz && \
	cd nginx-1.4.1 && \
	./configure --with-http_ssl_module && \
	make && \
	make install

# sort out mysql server
RUN mysqld_safe & sleep 10s

# Set up nginx configurations
RUN mkdir /usr/local/nginx/conf/sites-available && \
	mkdir /usr/local/nginx/conf/sites-enabled

# Expose some ports
EXPOSE 80

# Run the container
CMD service php5-fpm restart && \
	/usr/local/nginx/sbin/nginx