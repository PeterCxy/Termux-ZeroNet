#!/data/data/com.termux/files/usr/bin/bash

if [[ -z "$ZERONET_HOME" ]]; then
	echo "--- Installing ZeroNet ---"
	termux-setup-storage
	apt-get -y update && apt-get -y upgrade
	apt-get install -y curl make python2-dev git gcc grep c-ares-dev libev-dev
	export LIBEV_EMBED=false
	export CARES_EMBED=false
	pip2 install gevent msgpack-python

	if [[ ! -d ~/storage/shared/ZeroNet ]]; then
		mkdir ~/storage/shared/ZeroNet
		git clone https://github.com/HelloZeroNet/ZeroNet.git ~/storage/shared/ZeroNet
	fi

	cp "$0" ~/zn.sh
	echo 'export ZERONET_HOME=~/storage/shared/ZeroNet' >> ~/.bashrc
	echo "alias zn=\"bash ~/zn.sh\"" >> ~/.bashrc
	source ~/.bashrc

fi

if [[ "$1" == "update" ]]; then
	echo "--- Updating ZeroNet ---"
	pushd $ZERONET_HOME
	git pull
	popd
else
	pushd $ZERONET_HOME
	python2 zeronet.py $@
	popd
fi
