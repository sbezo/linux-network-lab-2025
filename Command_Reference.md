
## Jumping to linux

```
docker exec -it l1 bash
```
### IPSec troubleshooting (under linux shell)
```
ipsec status
ipsec traffic
ipsec stop
ipsec start

# realtime debug:
ipsec pluto --stderrlog --nofork
```

### adding certificates to NSS
```
# init nss:
ipsec initnss

# add user certificate to nss:
pk12util -i /etc/ipsec.d/certs/l2.p12 -d sql:/var/lib/ipsec/nss -K "" -W ""

# add CA to nss:
certutil -A -n "LabRootCA" -t "CT,C,C" -d sql:/var/lib/ipsec/nss -i /etc/ipsec.d/cacerts/ca.crt

# check certificates in nss database:
certutil -L -d sql:/var/lib/ipsec/nss
```

### check csr
```
openssl req -in certs/l2/l2.csr -text
```
### check crt
```
openssl x509 -in certs/l2/l2.crt -text
```

## Jumping to VRR
```
docker exec -it l1 vtysh
```
Or from linux just:
```
vtysh
```
## few useful vrr commands
```
show run
show interface brief
show ip route
sh ip bgp sum
show ip bgp neighbors 10.0.10.2 received-routes
show ip bgp neighbors 10.0.10.2 advertised-routes 
clear ip bgp *
```



