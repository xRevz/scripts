#!/bin/bash	

function start(){
iptables -F
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

#Barrando ataques no kernel
echo "1" > /proc/sys/net/ipv4/tcp_syncookies

#Bloq range Ipv4 Asia
#for i in `cat /opt/deny/pfB_Top_v4.txt`
#do  
#iptables -A FORWARD -s $i -p tcp --dport 80 -j DROP
#iptables -A FORWARD -d $i -p tcp --sport 22 -j DROP
#done

#for i in `cat /opt/deny/bloq.txt`
#do
#iptables -A FORWARD -s $i -p tcp --dport 80 -j DROP
#iptables -A FORWARD -d $i -p tcp --sport 22 -j DROP
#done


#Bloq Range Ipv6 Asia
#for l in `cat /opt/deny/pfB_Asia_v6.txt`
#do 
#iptables -A FORWARD -s $l -p tcp --dport 80 -j DROP 
#iptables -A FORWARD -d $l -p tcp --sport 22 -j DROP
#done

#Bloq Range Ipv4 Europa
#for m in `cat /opt/deny/pfB_Europe_v4.txt`
#do 
#iptables -A FORWARD -s $m -p tcp --dport 80 -j DROP 
#iptables -A FORWARD -d $m -p tcp --sport 22 -j DROP
#done

#Bloq Range Ipv6 Europa
#for n in `cat /opt/deny/pfB_Europe_v6.txt`
#do 
#iptables -A FORWARD -s $n -p tcp --dport 80 -j DROP 
#iptables -A FORWARD -d $n -p tcp --sport 22 -j DROP
#done

# INPUT iptables Rules
# Accept loopback input
iptables -A INPUT -i lo -p all -j ACCEPT

# allow 3 way handshake
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

### DROPspoofing packets
iptables -A INPUT -s 10.0.0.0/8 -j DROP 
iptables -A INPUT -s 169.254.0.0/16 -j DROP
iptables -A INPUT -s 172.16.0.0/12 -j DROP
iptables -A INPUT -s 127.0.0.0/8 -j DROP
iptables -A INPUT -s 192.168.0.0/24 -j DROP
iptables -A INPUT -s 224.0.0.0/4 -j DROP
iptables -A INPUT -d 224.0.0.0/4 -j DROP
iptables -A INPUT -s 240.0.0.0/5 -j DROP
iptables -A INPUT -d 240.0.0.0/5 -j DROP
iptables -A INPUT -s 0.0.0.0/8 -j DROP
iptables -A INPUT -d 0.0.0.0/8 -j DROP
iptables -A INPUT -d 239.255.255.0/24 -j DROP
iptables -A INPUT -d 255.255.255.255 -j DROP

#for SMURF attack protection
iptables -A INPUT -p icmp -m icmp --icmp-type address-mask-request -j DROP
iptables -A INPUT -p icmp -m icmp --icmp-type timestamp-request -j DROP
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -m limit --limit 1/second -j ACCEPT

# Droping all invalid packets
iptables -A INPUT -m state --state INVALID -j DROP
iptables -A FORWARD -m state --state INVALID -j DROP
iptables -A OUTPUT -m state --state INVALID -j DROP

# flooding of RST packets, smurf attack Rejection
iptables -A INPUT -p tcp -m tcp --tcp-flags RST RST -m limit --limit 2/second --limit-burst 2 -j ACCEPT

# Protecting portscans
# Attacking IP will be locked for 24 hours (3600 x 24 = 86400 Seconds)

iptables -A INPUT -m recent --name portscan --rcheck --seconds 86400 -j DROP
iptables -A FORWARD -m recent --name portscan --rcheck --seconds 86400 -j DROP

# Remove attacking IP after 24 hours
iptables -A INPUT -m recent --name portscan --remove
iptables -A FORWARD -m recent --name portscan --remove

# These rules add scanners to the portscan list, and log the attempt. - PART 2
iptables -N PORT-SCANNING
iptables -A PORT_SCANNING -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j RETURN
iptables -A PORT-SCANNING -j DROP

iptables -A INPUT -p tcp -m tcp --dport 139 -m recent --name portscan --set -j LOG --log-prefix "portscan:"
iptables -A INPUT -p tcp -m tcp --dport 139 -m recent --name portscan --set -j DROP

iptables -A FORWARD -p tcp -m tcp --dport 139 -m recent --name portscan --set -j LOG --log-prefix "portscan:"
iptables -A FORWARD -p tcp -m tcp --dport 139 -m recent --name portscan --set -j DROP

# Allow the following ports through from outside



iptables -A INPUT -p tcp -m tcp --dport 3555 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 3306 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT

iptables -A INPUT -p udp -m udp --dport 80 -j ACCEPT

iptables -A INPUT -p udp -m udp --dport 443 -j ACCEPT


# Allow ping means ICMP port is open (If you do not want ping replace ACCEPT with REJECT)
iptables -A INPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# Lastly reject All INPUT traffic
iptables -A INPUT -j REJECT


################# Below are for OUTPUT iptables rules #############################################

## Allow loopback OUTPUT 
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow the following ports through from outside 
# SMTP = 25
# DNS =53
# HTTP = 80
# HTTPS = 443
# SSH = 22
### You can also add or remove port no. as per your requirement

iptables -A FORWARD -p tcp -m tcp --dport 25 -j ACCEPT
iptables -A FORWARD -p udp -m udp --dport 53 -j ACCEPT
iptables -A FORWARD -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A FORWARD -p tcp -m tcp --dport 443 -j ACCEPT
iptables -A FORWARD -p tcp -m tcp --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp -m tcp --dport 3555 -j ACCEPT
iptables -A FORWARD -p tcp -m tcp --dport 3306 -j ACCEPT


# Allow pings
iptables -A OUTPUT -p icmp -m icmp --icmp-type 8 -j ACCEPT

# Lastly Reject all Output traffic
#iptables -A OUTPUT -j REJECT

## Reject Forwarding  traffic
#iptables -A FORWARD -j REJECT

## LOG everything
iptables -A INPUT -j LOG 
iptables -A FORWARD -j LOG 
#iptables -A INPUT -j DROP
ip6tables -A INPUT -j LOG
ip6tables -A FORWARD -j LOG


#Allow acess ips and ports Versa Tecnologia
iptables -I INPUT -s 177.136.192.252 -p tcp --dport 22 -j ACCEPT 
iptables -I INPUT -s 138.121.52.226 -p tcp --dport 22 -j ACCEPT 
iptables -I INPUT -s 177.136.192.252 -p tcp --dport 80 -j ACCEPT 
iptables -I INPUT -s 138.121.52.226 -p tcp --dport 80 -j ACCEPT 

echo "Started Firewal!"
}

function stop(){

iptables -F
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
echo "Stoped Firewall"
}


case $1 in
start)
start
;;
stop)
stop
;;
restart)
restart
;;
*)
echo "Usar: $0 {start, stop ou restart}"
;;
esac

