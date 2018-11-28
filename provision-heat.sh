#!/bin/bash
last_update=$(stat -c %Y /var/cache/apt/pkgcache.bin)
now=$(date +%s)
if [ $((now - last_update)) -gt 86400 ]; then
	apt-get update -y
	apt-get upgrade -y
fi

apt-get install -y postgresql postgresql-contrib nano git golang-go

if [ ! -f ~/setup_db.done ]; then
	sudo -u postgres psql -f /vagrant/setup_db.sql
	touch ~/setup_db.done
fi

if [ ! -f ~/setup_tables.done ]; then
	sudo -u postgres psql -d heat -f /vagrant/setup_tables.sql
	touch ~/setup_tables.done
fi

sed -i -e"s/^#listen_addresses =.*$/listen_addresses = '*'/" /etc/postgresql/10/main/postgresql.conf
echo "host    all    all    0.0.0.0/0    md5" >> /etc/postgresql/10/main/pg_hba.conf

service postgresql restart

go get github.com/lib/pq

echo "All done"