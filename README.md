The goal of this lab is to build, test and document IPSec with IKEv2, VTI, certs and BGP.

## Lab topology
<img width="902" height="258" alt="image" src="https://github.com/user-attachments/assets/55b04537-f1e1-4d1c-90e9-0135d8e0fa56" />


## Clone repository:
```
git clone https://github.com/sbezo/linux-network-lab-2025.git
cd linux-network-lab-2025
```

## Prepare certificates:
You can use existing certificates and skip this step, 
or create your own new certificates by:

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
chmod +x ./push_cfg.sh
./push_cfg.sh
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

