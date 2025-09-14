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

## Check End to end connectivity
Jump to l1 router
```
docker exec -it l1 bash
```
Then jump to vtysh (Cisco-like CLI):
```
vtysh
```

and ping interface of l4 router
```
ping 10.0.2.10
```
---------------------------
