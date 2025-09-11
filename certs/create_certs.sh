# paste inside alpine container:

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
  -out ca/ca.cert

#################################################################
# l2 private key
openssl genrsa -out l2/l2.key 2048

# l2 CSR
openssl req -new -key l2/l2.key \
  -subj "/C=SK/O=LabCA/CN=l2.lab" \
  -out l2/l2.csr

# Sign CSR with CA
openssl x509 -req -in l2/l2.csr -CA ca/ca.cert -CAkey ca/ca.key \
  -CAcreateserial -out l2/l2.cert -days 365 -sha256

#################################################################
# l3 private key
openssl genrsa -out l3/l3.key 2048

# l3 CSR
openssl req -new -key l3/l3.key \
  -subj "/C=SK/O=LabCA/CN=l3.lab" \
  -out l3/l3.csr

# Sign CSR with CA
openssl x509 -req -in l3/l3.csr -CA ca/ca.cert -CAkey ca/ca.key \
  -CAcreateserial -out l3/l3.cert -days 365 -sha256


