############################################################
# Dockerfile to build CentOS,Nginx e PHP-FPM installed Container
# Based on CentOS
############################################################

FROM centos:6.6

# File Author / Maintainer
MAINTAINER Josimar Camargo <josimar.camargo@gmail.com>

# Adding the ngix and PHP dependent repository
ADD nginx.repo /etc/yum.repos.d/nginx.repo

# Adding repo epel
RUN rpm -Uvh http://fedora.uib.no/epel/6/x86_64/epel-release-6-8.noarch.rpm

# Updating System
RUN yum -y update

# Installing nginx and PHP and popular extensions
RUN yum -y install nginx php-fpm php-soap php-xml php php-mysql php-xmlrpc php-gd php-mbstring 

# Clean cache from yum
RUN yum clean all

# Adding config file to php-fpm
ADD php-fpm.conf /etc/php-fpm.d/php-fpm.conf

# Adding the configuration file of the nginx
ADD nginx.conf /etc/nginx/nginx.conf

#Disabling nginx daeomonize impedindo que o nginx saia do primeiro plano e o container seja encerrado
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf 

# Making directory for server-blocks
RUN mkdir /etc/nginx/sites-enabled

# Adding Config localhost
ADD localhost /etc/nginx/sites-enabled/localhost

# Removing default configs
RUN rm -rf /etc/nginx/conf.d/default.conf
RUN rm -rf /etc/nginx/conf.d/example_ssl.conf
RUN rm -rf /etc/php-fpm.d/www.conf
RUN rm -rf /usr/share/nginx/html


#Configuring php for php-fpm
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php.ini

# Starting sevices 
#RUN service php-fpm start
#RUN service nginx start

# Adding the default file for testing php under nginx
ADD html/index.php /var/www/html/index.php

# Adding script for start services
ADD start.sh /start.sh

# Adding permission to execute
RUN chmod +x /start.sh

# Set the port to 80 
EXPOSE 80

# Executing nginx and php-fpm, com este comando no Dockerfile vc não precisar add o comando na hora do docker run
CMD ["/start.sh"]
