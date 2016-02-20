#!/bin/bash
echo "------------ Starting provisioning script -------------------------------------"

# include config variables
. /vagrant/devops/config

sudo apt-get update && sudo apt-get -y upgrade

echo "------------ Git & Node -------------------------------------------------------"
sudo apt-get install -y git nodejs
sudo update-alternatives --install /usr/bin/node nodejs /usr/bin/nodejs 100

echo "------------ Postgresql -------------------------------------------------------"
sudo apt-get install -y postgresql postgresql-contrib > /dev/null 2>&1
sudo -u postgres psql --command "create user $DBUSER with password '$DBPASSWD';"
sudo -u postgres psql --command "alter user $DBUSER with createdb;"
sudo mv /etc/postgresql/9.3/main/pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf.bak
sudo cp /vagrant/devops/pg_hba-skeleton.conf /etc/postgresql/9.3/main/pg_hba.conf
sudo service postgresql restart

echo "------------ Install RVM ------------------------------------------------------"

sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | sudo bash -s stable --ruby=2.3.0

echo "------------ Source RVM -------------------------------------------------------"
source /usr/local/rvm/scripts/rvm

echo "------------ Install Dependencies ---------------------------------------------"
sudo apt-get install -y apache2 apache2-dev libcurl4-gnutls-dev apache2 libapache2-svn libapache-dbi-perl libapache2-mod-perl2 libdbd-mysql-perl libauthen-simple-ldap-perl openssl libgmp-dev

sudo dpkg --configure -a

echo "------------ Run a2enmod ------------------------------------------------------"
sudo a2enmod ssl perl dav dav_svn dav_fs rewrite

echo "------------ Add user to rvm group --------------------------------------------"
sudo adduser vagrant rvm

echo "------------ Start new shell --------------------------------------------------"
su - vagrant

echo "------------ Install Bundler gem --------------------------------------------"
export rvmsudo_secure_path=1
rvmsudo gem install bundler

echo "------------ Install Passenger gem --------------------------------------------"
export rvmsudo_secure_path=1
rvmsudo gem install passenger --version 4.0.53

echo "------------ Run passenger-install-apache2-module -----------------------------"
rvmsudo passenger-install-apache2-module

echo "------------ Update apache config ---------------------------------------------"
sudo mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bak
sudo cp /vagrant/devops/apache-skeleton.conf /etc/apache2/sites-available/000-default.conf

echo "------------ Update passenger config ------------------------------------------"
sudo cp /vagrant/devops/passenger-skeleton.conf /etc/apache2/conf-available/passenger.conf

echo "------------ Load passenger config and restart apache -------------------------"
sudo a2enconf passenger
sudo service apache2 restart

echo "------------ Install project gems ---------------------------------------------"
cd /vagrant
bundle install

echo "------------ Setup DB ---------------------------------------------------------"
rake db:create
rake db:setup RAILS_ENV=development

