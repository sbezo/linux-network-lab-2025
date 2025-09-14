🚧🚧🚧 Under construction, not ready yet! 🚧🚧🚧



The goal of this lab is to build, test and document IPSec with IKEv2, VTI, certs and BGP on FRR + LibreSwan.
Whole LAB is reproducible in docker. You can just follows instructions.   

## Lab topology
<img width="902" height="258" alt="image" src="https://github.com/user-attachments/assets/55b04537-f1e1-4d1c-90e9-0135d8e0fa56" />


## Clone repository:
```
git clone https://github.com/sbezo/linux-network-lab-2025.git
cd linux-network-lab-2025
```

## Prepare certificates:
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

## Spin up LAB:
```
docker compose up -d --build
```

## Push config to devices:
```
chmod +x ./push_cfg_rsa.sh
./push_cfg_rsa.sh
```

## Check IPSec

Jump to l2 router
```
docker exec -it l2 bash
```
and run:
```
ipsec status
ipsec traffic
```
Then jump to vtysh (Cisco-like CLI):
```
vtysh
```
and run:
```
ping 172.16.0.11
```

# Useful commands.  

### IPSec debug
```
ipsec pluto --stderrlog --nofork
ipsec status
ipsec stop
ipsec start
```

### adding certificates to NSS
```
ipsec initnss
pk12util -i /etc/ipsec.d/certs/l2.p12 -d sql:/var/lib/ipsec/nss -K "" -W ""
certutil -A -n "LabRootCA" -t "CT,C,C" -d sql:/var/lib/ipsec/nss -i /etc/ipsec.d/cacerts/ca.crt
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

