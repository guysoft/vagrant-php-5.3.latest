#!/bin/sh

# NB: librarian-puppet might need git installed. If it is not already installed
# in your basebox, this will manually install it at this point using apt or yum
export DEBIAN_FRONTEND=noninteractive


#sudo sed -i  's@http.us.debian.org/debian@archive.debian.org/debian@g' /etc/apt/sources.list
#sudo sed -i  's@squeeze-updates@squeeze@g' /etc/apt/sources.list
apt-get update
apt-get upgrade -y
apt-get -q -y install git
apt-get -y install mysql-client php5-mysql
apt-get -y install php5
apt-get -y install apache2 libapache2-mod-php5
/etc/init.d/apache2 restart
exit 0
