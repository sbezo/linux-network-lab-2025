# Dockerfile
FROM ubuntu:22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    iproute2 iputils-ping tcpdump \
    frr frr-pythontools \
    libreswan \
    systemctl \
    vim nano && \
    rm -rf /var/lib/apt/lists/*

# Create a directory for startup scripts
RUN mkdir -p /usr/local/bin

# Copy the startup script
COPY common_network_setup.sh /usr/local/bin/common_network_setup.sh
RUN chmod +x /usr/local/bin/common_network_setup.sh

# Default command: run startup script
CMD ["/usr/local/bin/common_network_setup.sh"]