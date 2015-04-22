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

# Installing nginx and PHP and popular extensions
RUN yum -y install nginx php-fpm php-soap php-xml php php-mysql php-xmlrpc php-gd php-mbstring 

# Adding config file to php-fpm
ADD www.conf /etc/php-fpm.d/php-fpm.conf

# Adding the configuration file of the nginx
ADD nginx.conf /etc/nginx/nginx.conf

#Disabling nginx daeomonize impedido que o nginx saia do primeiro plano e o container seja encerrado
RUN echo "daemon off;" >> /etc/nginx/nginx.conf 

# Making Directory to server-blocks
RUN mkdir /etc/nginx/site-enabled

# Adding Confg locahost
ADD localhost /etc/nginx/site-enabled/localhost

# Removing default configs
RUN rm -rf /etc/nginx/conf.d/default.conf
RUN rm -rf /etc/nginx/conf.d/example_ssl.conf
#RUN rm -rf /etc/php-fpm.d/mv www.conf 

# Starting sevices 
RUN service php-fpm start
RUN service nginx start

# Set the port to 80 
EXPOSE 80

# Executing nginx and php-fpm
CMD ["\start.sh"]
