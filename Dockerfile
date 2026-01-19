FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI during build (not at runtime)
RUN NONINTERACTIVE=1 curl -sSf https://cli.nexus.xyz/ | sh

# Create a startup script
RUN echo '#!/bin/bash\n/root/.nexus/bin/nexus-cli start --node-id 37610033' > /start.sh && \
    chmod +x /start.sh

# Run the startup script
CMD ["/bin/bash", "/start.sh"]eadless"]
