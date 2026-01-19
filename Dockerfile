FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI
RUN curl https://cli.nexus.xyz/ | sh

# Set working directory
WORKDIR /root

# Keep container running and start nexus
CMD ["/bin/bash", "-c", "/root/.nexus/bin/nexus run"]
