echo ""
	echo "Network info: "
	#Get ip address, filter out junk & remove loopback adapter

	AMOUNT=$(ip addr show | grep 'inet ' | grep -v ' lo' | wc -l)
	for ((i=1;i<=$AMOUNT;i++))
	do
		IPLIST_RAW="$(ip addr show | grep 'inet ' | grep -v ' lo' | head -n $i | tail -1)"
		IPLIST="IP-address: \t $(echo $IPLIST_RAW | cut -f 2 -d ' ')"
		SUBNET="\t \t subnet: $(echo $IPLIST_RAW | cut -f 4 -d ' ')"
		INTERFACE="\t \t Interface: $(echo $IPLIST_RAW | cut -f 7- -d ' ')"
		OUTPUT="$IPLIST   $SUBNET   $INTERFACE"
		echo -e $OUTPUT
	done
	echo ""
