#!/usr/bin/env sh

if [ $# -lt 1 ]; then
    echo >&2 "Usage: $(basename $0) {up|down} [DEVICE]"
fi

device=${2:-enp5s5}

case "${1}" in
up)
	ip netns add rext
	ip link add rext-mit type veth peer name rext-ext
	ip link add rint-mit type veth peer name rint-int

	ip link set rext-mit up
	offload-tcp rext-mit off

	ip link set rext-ext netns rext
	ip netns exec rext offload-tcp rext-ext off
	ip netns exec rext ip address add 10.8.1.1/24 dev rext-ext 
	ip netns exec rext ip link set rext-ext up

	ip netns exec rext ip link set lo up

	ip netns exec rext ip route add default via 10.8.1.2

	ip link set rint-mit up
	offload-tcp rint-mit off

	ip link set rint-int up
	offload-tcp rint-int off
	ip address add 10.8.1.2/24 dev rint-int

	iptables -t nat -A POSTROUTING -o ${device} -j MASQUERADE
	iptables -A FORWARD -i ${device} -o rint-int -m state --state RELATED,ESTABLISHED -j ACCEPT
	iptables -A FORWARD -i rint-int -o ${device} -j ACCEPT
	;;

down)
	ip netns delete rext

	ip link delete rext-mit # + rext-ext
	ip link delete rint-mit # + rint-int

	iptables -t nat -D POSTROUTING -o ${device} -j MASQUERADE
	iptables -D FORWARD -i ${device} -o rint-int -m state --state RELATED,ESTABLISHED -j ACCEPT
	iptables -D FORWARD -i rint-int -o ${device} -j ACCEPT
	;;
esac
