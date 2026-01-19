FROM ubuFROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI
RUN NONINTERACTIVE=1 curl -sSf https://cli.nexus.xyz/ | sh

# Simple start with node ID (just like your local command)
CMD ["/root/.nexus/bin/nexus-cli", "start", "--node-id", "37610033"]
