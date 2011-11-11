#!/bin/sh

UID=`ifconfig eth0 | grep HWaddr | awk '{print $5}' | sed 's/://g'`

[ -e /etc/functions.sh ] && . /etc/functions.sh || . ./functions.sh

gate_generate_keys() {
	rm -f /tmp/astral-tinc.conf
	rm -f /etc/tinc/astral/rsa_key.*
	echo | tincd -n astral -K512 > /dev/null 2>&1
}

gate_sync_hosts() {
	local enabled
	local keeper
	local secret

	config_get_bool enabled $1 enabled
	config_get keeper $1 keeper
	config_get secret $1 secret
	config_get hostname $1 hostname

	[ "${enabled}" -eq 0 ] && return 1

	echo $secret > /tmp/keeper-secret
	chmod 600 /tmp/keeper-secret
	if [ -f /etc/tinc/astral/rsa_key.priv ]; then
            if ! egrep -q ^Address=$hostname$ /etc/tinc/astral/rsa_key.pub; then
                sed "/^Address=.*/d" -i /etc/tinc/astral/rsa_key.pub
                echo "Address=$hostname" >> /etc/tinc/astral/rsa_key.pub
            fi
	rsync /etc/tinc/astral/rsa_key.pub rsync://astralgate@$keeper:/hosts/$UID --password-file=/tmp/keeper-secret -c
        fi
	rsync rsync://astralgate@$keeper:/hosts/* /etc/tinc/astral/hosts/ --password-file=/tmp/keeper-secret -c
	rm /tmp/keeper-secret
}

gate_generate_config() {
	local enabled
	local mode
	config_get_bool enabled $1 enabled
	config_get mode $1 mode
	[ "${enabled}" -eq 0 ] && return 1
	echo "Device = /dev/net/tun" > /tmp/astral-tinc.conf
	echo "Interface = astral" >> /tmp/astral-tinc.conf
	echo "Mode = $mode" >> /tmp/astral-tinc.conf
	echo "Name = $UID" >> /tmp/astral-tinc.conf
	for host in $(ls /etc/tinc/astral/hosts/); do
	if [ "$host" != "$UID" ]; then
	echo ConnectTo=$host >> /tmp/astral-tinc.conf
	fi
	done
}
	
sync_hosts() {
	config_load astral
	config_foreach gate_sync_hosts gate
}

generate_config() {
	config_load astral
	config_foreach gate_generate_config gate
}
case "$1" in
	generate_keys)
	gate_generate_keys
	;;
	sync_hosts)
	sync_hosts
	;;
	generate_config)
	generate_config
	;;
esac
