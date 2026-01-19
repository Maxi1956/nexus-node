FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI
RUN NONINTERACTIVE=1 curl -sSf https://cli.nexus.xyz/ | sh

# Just keep container running
CMD ["tail", "-f", "/dev/null"]
