FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*

# Install Nexus CLI
RUN NONINTERACTIVE=1 curl -sSf https://cli.nexus.xyz/ | sh

# Create .nexus directory and config
RUN mkdir -p /root/.nexus
RUN echo '{"node_id": "37610033"}' > /root/.nexus/config.json

# Debug: Check what was installed
RUN ls -la /root/.nexus/ || echo "No .nexus directory"
RUN ls -la /root/.nexus/bin/ || echo "No bin directory"

# Create a startup script with error handling
RUN echo '#!/bin/bash\n\
set -x\n\
echo "=== Starting Nexus CLI ==="\n\
echo "Checking nexus-cli location..."\n\
which nexus-cli || echo "nexus-cli not in PATH"\n\
ls -la /root/.nexus/bin/ || echo "No bin directory"\n\
if [ -f /root/.nexus/bin/nexus-cli ]; then\n\
  echo "Found nexus-cli, starting..."\n\
  /root/.nexus/bin/nexus-cli start --headless\n\
else\n\
  echo "ERROR: nexus-cli not found!"\n\
  exit 1\n\
fi' > /start.sh

RUN chmod +x /start.sh

CMD ["/bin/bash", "/start.sh"]
