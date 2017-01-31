#!/data/data/com.termux/files/usr/bin/bash

if [[ -z "$ZERONET_HOME" ]]; then
	echo "--- Installing ZeroNet ---"
	termux-setup-storage
	apt-get -y update && apt-get -y upgrade 
	apt-get install -y curl make python2-dev git clang grep c-ares-dev libev-dev openssl-tool
	export LIBEV_EMBED=false
	export CARES_EMBED=false
	export CONFIG_SHELL=$PREFIX/bin/sh
	export TMPDIR=$PREFIX/tmp
	EMBED=0 pip2 install gevent msgpack-python

	if [[ ! -d ~/ZeroNet ]]; then
		cd ~
		curl -L https://github.com/HelloZeroNet/ZeroNet/archive/master.tar.gz | tar xz
		mv ~/ZeroNet-master ~/ZeroNet

	fi

	echo 'export ZERONET_HOME=~/ZeroNet' >> ~/.bashrc
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
