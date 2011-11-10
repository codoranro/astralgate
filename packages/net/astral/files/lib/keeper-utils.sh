#!/bin/sh

[ -e /etc/functions.sh ] && . /etc/functions.sh || . ./functions.sh

keeper_generate_config() {
	local enabled
	local secret
	local storage
	
	config_get enabled $1 enabled
	config_get secret $1 secret
	config_get storage $1 storage
        echo "uid = root
gid = root
use chroot = yes
pid file = /var/run/rsyncd.pid

[hosts]
comment = AstralGate hosts
auth users = astralgate
secrets file = /tmp/astral-keeper-rsyncd.secrets
read only = no" > /tmp/astral-keeper-rsyncd.conf
	echo "path = $storage" >> /tmp/astral-keeper-rsyncd.conf
	echo "astralgate:$secret" > /tmp/astral-keeper-rsyncd.secrets
	chmod 700 /tmp/astral-keeper-rsyncd.secrets
	mkdir -p $storage
}

generate_config() {                                                             
        config_load astral                                                      
	config_foreach keeper_generate_config keeper                                  
}     

case "$1" in
	generate_config)
	generate_config
	;;
esac
