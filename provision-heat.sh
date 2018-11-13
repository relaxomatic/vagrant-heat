#!/bin/bash
last_update=$(stat -c %Y /var/cache/apt/pkgcache.bin)
now=$(date +%s)
if [ $((now - last_update)) -gt 3600 ]; then
	apt-get update -y
	apt-get upgrade -y
fi

apt-get install -y postgresql postgresql-contrib nano git golang-go

if [ ! -f /vagrant/setup_db.done ]; then
	sudo -u postgres psql -f /vagrant/setup_db.sql
	touch /vagrant/setup_db.done
fi

sed -i -e"s/^#listen_addresses =.*$/listen_addresses = '*'/" /etc/postgresql/10/main/postgresql.conf
echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/10/main/pg_hba.conf

service postgresql restart