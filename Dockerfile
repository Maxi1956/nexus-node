FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl bash && rm -rf /var/lib/apt/lists/*
RUN NONINTERACTIVE=1 curl -sSf https://cli.nexus.xyz/ | sh

RUN echo '#!/bin/bash\n\
echo "=== Starting Nexus CLI ==="\n\
echo "Node ID: 37610033"\n\
echo "Time: $(date)"\n\
/root/.nexus/bin/nexus-cli start --node-id 37610033 --headless 2>&1 | while IFS= read -r line; do echo "[NEXUS] $line"; done &\n\
NEXUS_PID=$!\n\
echo "Nexus CLI PID: $NEXUS_PID"\n\
while kill -0 $NEXUS_PID 2>/dev/null; do\n\
  echo "Status check: Still running ($(date))"\n\
  sleep 300\n\
done\n\
echo "ERROR: Nexus CLI stopped unexpectedly"\n\
exit 1\n\
' > /start.sh && chmod +x /start.sh

CMD ["/bin/bash", "/start.sh"]
