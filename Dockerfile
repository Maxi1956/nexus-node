FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl bash net-tools && rm -rf /var/lib/apt/lists/*
RUN NONINTERACTIVE=1 curl -sSf https://cli.nexus.xyz/ | sh

CMD /bin/bash -c '\
echo "Starting Nexus CLI at $(date)"; \
stdbuf -oL /root/.nexus/bin/nexus-cli start --node-id 37610033 --headless & \
NEXUS_PID=$!; \
echo "Nexus PID: $NEXUS_PID"; \
sleep 10; \
echo "Network connections:"; \
netstat -tupn 2>/dev/null || ss -tupn; \
tail -f /dev/null'
