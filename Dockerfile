FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI
RUN NONINTERACTIVE=1 curl -sSf https://cli.nexus.xyz/ | sh

# Create .nexus directory
RUN mkdir -p /root/.nexus

# Create proper config.json
# The CLI needs both user registration and node registration
RUN echo '{\n\
  "prover_id": "37610033",\n\
  "node_id": "37610033"\n\
}' > /root/.nexus/config.json

# Start the CLI with the node ID flag
CMD ["/root/.nexus/bin/nexus-cli", "start", "--node-id", "37610033"]
