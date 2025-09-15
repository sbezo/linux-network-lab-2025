The goal of this lab is to build, test and document IPSec with IKEv2, VTI, RSA and BGP on FRR + LibreSwan.  
You can get fully functional lab in 4 easy copy-paste steps and you can start play.  
The only prerequisite is docker.  


## Lab topology
<img width="841" height="204" alt="image" src="https://github.com/user-attachments/assets/49fd5ef0-7cd3-43b9-84be-2b142503ba91" />



## 1. Clone repository:
```
git clone https://github.com/sbezo/linux-network-lab-2025.git
cd linux-network-lab-2025
```

## 2. Prepare certificates:
Create your own new certificates.   
You need to run this just once.

```
rm -rf ./certs
mkdir certs
cp create_certs.sh certs/
cd certs
chmod +x ./create_certs.sh
docker run --rm -it -v "$PWD":/root alpine sh  /root/create_certs.sh
cd ..
```

## 3. Spin up LAB:
```
docker compose up -d --build
```

## 4. Push config to devices:
```
chmod +x ./push_cfg_rsa.sh
./push_cfg_rsa.sh
```

## Check end-to-end connectivity
Jump to l1 router vtysh
```
docker exec -it l1 vtysh
```
and ping interface of l4 router
```
ping 10.0.2.10
```
Wait up to 30 seconds while IPSec, BGP and OSPF will bring fully up.

---------------------------
---------------------------
---------------------------


# Useful commands.  

## Jumping to linux
```
docker exec -it l2 bash
```
## IPSec troubleshooting (under linux shell)
```
ipsec status
ipsec traffic
ipsec stop
ipsec start

# realtime debug:
ipsec pluto --stderrlog --nofork
```

## adding certificates to NSS
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

## check csr
```
openssl req -in certs/l2/l2.csr -text
```
## check crt
```
openssl x509 -in certs/l2/l2.crt -text
```

## Jumping to VRR
```
docker exec -it l2 vtysh
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




