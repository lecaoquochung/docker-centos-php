FROM centos:6

# EPEL 6
# https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
# RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# Update PHP version
# RUN rpm -ivh https://rpms.famillecollet.com/enterprise/remi-release-6.rpm

# Dependencies
RUN yum update -y
RUN yum install -y httpd
RUN yum install --enablerepo=epel,remi-php56,remi -y \
                              php php-devel php-intl \
                              php-cli php-curl \
                              php-gd \
                              php-mbstring \
                              php-mcrypt \
                              php-mysqlnd \
                              php-pdo \
                              php-xml \
                              php-xdebug \
                              php-memcached \
                              mysql-server \
                              phpmyadmin \
                              mod_ssl openssl \
                              rsync

RUN sed -i -e "s|^;date.timezone =.*$|date.timezone = Asia/Tokyo|" /etc/php.ini

# PROJECT

# Default Docker Dev
COPY httpd.conf /etc/httpd/conf.d/virtual.conf
# TODO: allow exclude cp !()
RUN shopt -s extglob

# SSL 
# Only use this with local Docker
# Please don't use default private key for production server
# TODO Config SSL for local Docker
COPY ssl/ca.crt /etc/pki/tls/certs/ca.crt
COPY ssl/ca.key /etc/pki/tls/private/ca.key
RUN chmod 500 /etc/pki/tls/certs/ca.crt
RUN chmod 500 /etc/pki/tls/private/ca.key
RUN restorecon -RvF /etc/pki

# RUN iptables -A INPUT -p tcp --dport 443 -j ACCEPT
# RUN /sbin/service iptables save
# RUN iptables -L -v

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
