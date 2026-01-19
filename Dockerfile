FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI
RUN NONINTERACTIVE=1 curl -sSf https://cli.nexus.xyz/ | sh

# Create .nexus directory and config
RUN mkdir -p /root/.nexus

# Create config.json with your node ID
RUN echo '{"node_id": "37610033"}' > /root/.nexus/config.json

# Start the CLI in headless mode
CMD ["/root/.nexus/bin/nexus-cli", "start", "--headless"]
