/interface bridge
add igmp-snooping=yes name=bridge1
/interface ethernet
set 0 name=ether1-gateway
set 1 name=ether2-local
set 2 name=ether3-local
set 3 name=ether4-local
set 4 name=ether5-local
/interface vlan
add interface=ether1-gateway name=vlan2 vlan-id=2
add interface=ether1-gateway name=vlan3 vlan-id=3
add interface=ether1-gateway name=vlan6 vlan-id=6
/interface pppoe-client
add add-default-route=yes allow=pap,chap disabled=no interface=ether1-gateway keepalive-timeout=60 max-mru=1492 max-mtu=1492 name=pppoe-out1 password=adslppp use-peer-dns=yes user=adslppp@telefonicanetpa
/ip dhcp-server option
add code=240 name=option_para_deco value="':::::239.0.2.10:22222:v6.0:239.0.2.30:22222'"
/ip pool
add name=dhcp ranges=192.168.88.201-192.168.88.249
/ip dhcp-server
add address-pool=dhcp bootp-support=dynamic disabled=no interface=bridge1 name=Servidor_DHCP
/interface bridge port
add bridge=bridge1 interface=ether2-local
add bridge=bridge1 interface=ether3-local
add bridge=bridge1 interface=ether4-local
#add bridge=bridge1 interface=ether5-local
/interface bridge settings
set use-ip-firewall-for-pppoe=yes use-ip-firewall-for-vlan=yes
/ip neighbor discovery-settings
set discover-interface-list=!dynamic
/ip settings
set tcp-syncookies=yes
/ip address
add address=192.168.88.1/24 comment="default configuration" interface=bridge1 network=192.168.88.0
add address=192.168.100.10/24 interface=ether1-gateway network=192.168.100.0
/ip dhcp-client
add add-default-route=no dhcp-options=hostname,clientid disabled=no interface=vlan3 use-peer-ntp=no
/ip dhcp-server network
add address=192.168.88.0/24 dns-server=80.58.61.250,80.58.61.254 gateway=192.168.88.1 netmask=24
add address=192.168.88.200/30 dhcp-option=option_para_deco dns-server=1.1.1.1,8.8.8.8 gateway=192.168.88.1 netmask=24
/ip dns
set servers=80.58.61.250,80.58.61.254
/ip firewall filter
add chain=input comment="default configuration" protocol=icmp
add chain=input comment="default configuration" connection-state=established
add chain=input comment="default configuration" connection-state=related
add action=drop chain=input comment="default configuration" in-interface=pppoe-out1
add action=fasttrack-connection chain=forward connection-state=established,related	
add chain=forward comment="default configuration" connection-state=established
add chain=forward comment="default configuration" connection-state=related
add action=drop chain=forward comment="default configuration" connection-state=invalid
/ip firewall mangle
add action=set-priority chain=postrouting new-priority=4 out-interface=vlan3
add action=set-priority chain=postrouting new-priority=4 out-interface=vlan2
add action=set-priority chain=postrouting new-priority=1 out-interface=pppoe-out1
/ip firewall nat
add action=masquerade chain=srcnat comment="default configuration" out-interface=pppoe-out1
add action=masquerade chain=srcnat comment="default configuration" out-interface=ether1-gateway
add action=masquerade chain=srcnat comment="default configuration" out-interface=vlan2
add action=masquerade chain=srcnat comment="default configuration" out-interface=vlan3
add action=dst-nat chain=dstnat dst-address-type=local in-interface=vlan2 comment="VOD" to-addresses=192.168.88.200
/ip route
add distance=255 gateway=255.255.255.255
/ip upnp interfaces
add interface=bridge1 type=internal
add interface=pppoe-out1 type=external
#/routing igmp-proxy interface
#add alternative-subnets=0.0.0.0/0 interface=vlan2 upstream=yes
#add interface=bridge1
/routing rip interface
add interface=vlan3 passive=yes receive=v2
add interface=vlan2 passive=yes receive=v2
/routing rip network
add network=10.0.0.0/8
add network=172.26.0.0/16
/system clock
set time-zone-name=Europe/Madrid
/system identity
set name=Router-Core
/system ntp client
set enabled=yes primary-ntp=147.156.7.26 secondary-ntp=5.9.145.2
/interface bridge port add bridge=bridge1 interface=ether5-local
