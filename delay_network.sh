#!/bin/bash

interface=em1
ip=172.16.10.52
ip2=172.16.10.53
ip3=172.16.10.54
delay1=1ms
delay2=2ms
delay3=3ms

# delete qdisc
tc qdisc delete dev em1 root

# delete filter
tc filter del dev em1 prio 1

#
tc qdisc replace dev $interface root handle 1: prio
tc qdisc replace dev $interface parent 1:1 handle 10: netem delay $delay1
tc qdisc replace dev $interface parent 1:2 handle 20: netem delay $delay2
tc qdisc replace dev $interface parent 1:3 handle 30: netem delay $delay3
tc filter add dev $interface parent 1:0 protocol ip prio 1 u32 match ip dst $ip flowid 10:1
tc filter add dev $interface parent 1:0 protocol ip prio 1 u32 match ip dst $ip2 flowid 20:2
tc filter add dev $interface parent 1:0 protocol ip prio 1 u32 match ip dst $ip3 flowid 30:3
