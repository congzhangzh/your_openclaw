#!/bin/bash
set -e

echo "============================================"
echo " OpenClaw Gateway starting on port 18789"
echo "============================================"
echo ""
echo " Attach:  docker attach openclaw"
echo " Detach:  Ctrl+P, Ctrl+Q"
echo " Shell:   docker exec -it openclaw bash"
echo " Logs:    docker logs -f openclaw"
echo "============================================"

exec openclaw gateway --port 18789 --verbose --bind lan
