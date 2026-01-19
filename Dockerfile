FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    bash \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI
RUN curl https://cli.nexus.xyz/ | sh

# Set working directory
WORKDIR /rFROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set noninteractive installation
ENV DEBIAN_FRONTEND=noninteractive
ENV NONINTERACTIVE=1

# Install Nexus CLI
RUN curl -sSf https://cli.nexus.xyz/ -o install.sh && \
    chmod +x install.sh && \
    ./install.sh && \
    rm install.sh

# Set working directory
WORKDIR /root

# Start nexus with node ID
CMD ["/root/.nexus/bin/nexus-cli", "start", "--node-id", "37610033"]oot

# Create config directory
RUN mkdir -p /root/.nexus

# Create config.json with node ID
RUN echo '{"node_id": "37610033"}' > /root/.nexus/config.json

# Run nexus in headless mode
CMD ["/root/.nexus/bin/nexus-cli", "start", "--headless"]
