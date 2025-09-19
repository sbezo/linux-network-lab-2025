#!/bin/bash

# This is a hell script for creating CA, router certificates and pkcs12 files for l2 and l3
# Use it according to README.md - script is supposed to run inside alpine container

# install openssl
apk update && apk add openssl
cd /root
mkdir ca
mkdir l2
mkdir l3

# CA private key
openssl genrsa -out ca/ca.key 2048

# CA certificate (self-signed)
openssl req -x509 -new -nodes -key ca/ca.key -sha256 -days 3650 \
  -subj "/C=SK/O=LabCA/CN=LabRootCA" \
  -out ca/ca.crt

#################################################################
# l2 private key
openssl genrsa -out l2/l2.key 2048

# l2 CSR
openssl req -new -key l2/l2.key \
  -subj "/C=SK/O=LabCA/CN=l2.lab" \
  -addext "subjectAltName=IP:192.168.0.10" \
  -out l2/l2.csr

# Sign CSR with CA
openssl x509 -req -in l2/l2.csr -CA ca/ca.crt -CAkey ca/ca.key \
  -CAcreateserial -out l2/l2.crt -days 365 -sha256 \
  -copy_extensions copy

# pkcs12 from crt and key:
openssl pkcs12 -export \
  -in l2/l2.crt \
  -inkey l2/l2.key \
  -out l2/l2.p12 \
  -name "l2.lab" \
  -passout pass:

#################################################################
# l3 private key
openssl genrsa -out l3/l3.key 2048

# l3 CSR
openssl req -new -key l3/l3.key \
  -subj "/C=SK/O=LabCA/CN=l3.lab" \
  -addext "subjectAltName=IP:192.168.0.11" \
  -out l3/l3.csr

# Sign CSR with CA
openssl x509 -req -in l3/l3.csr -CA ca/ca.crt -CAkey ca/ca.key \
  -CAcreateserial -out l3/l3.crt -days 365 -sha256 \
  -copy_extensions copy

# pkcs12 from crt and key:
openssl pkcs12 -export \
  -in l3/l3.crt \
  -inkey l3/l3.key \
  -out l3/l3.p12 \
  -name "l3.lab" \
  -passout pass:
