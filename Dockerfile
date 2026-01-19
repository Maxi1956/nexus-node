FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI during build
RUN NONINTERACTIVE=1 curl -sSf https://cli.nexus.xyz/ | sh

# Create startup script with verbose logging
RUN echo '#!/bin/bash\n\
echo "Starting Nexus CLI..."\n\
echo "Node ID: 37610033"\n\
/root/.nexus/bin/nexus-cli start --node-id 37610033 || echo "Error code: $?"\n\
echo "Nexus CLI exited"\n\
sleep infinity' > /start.sh && chmod +x /start.sh

CMD ["/bin/bash", "/start.sh"]
