FROM ubuntu:22.04

# Install curl and other dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI
RUN curl https://cli.nexus.xyz/ | sh

# Set working directory
WORKDIR /root

# Run the Nexus prover
CMD ["/root/.nexus/bin/nexus", "run"]
