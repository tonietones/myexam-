#!/bin/bash

# Create the file repository configuration:
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Import the repository signing key:
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Update the package lists:
sudo apt -y update

# This will install the latest version of PostgreSQL package along with a -contrib package that adds some additional utilities and functionality:
sudo apt -y install postgresql postgresql-contrib

# Ensure that the PostgreSQL daemon is started
sudo systemctl start postgresql.service

# Create a new role (user) for postgres called
sudo -u postgres createuser --anthony
sudo -i -u postgres psql -c "CREATE USER anthony WITH ENCRYPTED PASSWORD 'anthony2022'"

# Create a new database
sudo -i -u postgres psql -c "CREATE DATABASE anthonydb WITH ENCODING 'UTF8' TEMPLATE template0"

# Grant anthony user privilege on the anthonydb database
sudo -i -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE anthonydb to anthony"

# Configure user login method in pg_hba.conf
echo -e 'local\tall\t\tanthony\t\t\t\tmd5' >>/etc/postgresql/15/main/pg_hba.conf

# Restart the PostgreSQL daemon
systemctl restart postgresql
