interface=cali2ef38683364
ip=172.16.10.3
delay1=20ms
tc filter del dev cali2ef38683364 prio 1
ip link set cali2ef38683364 qlen 1000
tc qdisc replace dev cali2ef38683364 root handle 1: prio
tc qdisc replace dev cali2ef38683364 parent 1:1 handle 10: netem delay 20ms
tc filter add dev cali2ef38683364 parent 1:0 protocol ip prio 1 u32 match ip src 172.16.10.3 flowid 10:1
