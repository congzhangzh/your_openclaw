#!/bin/bash
# =============================================================================
# OpenClaw Setup — onboard first, CLI for fine-tuning
# =============================================================================
# Run INSIDE the container:
#   docker compose run --rm openclaw bash setup.sh
# =============================================================================

set -e

echo "============================================"
echo " OpenClaw Setup"
echo "============================================"

# --- Step 1: Onboard ---
openclaw onboard

# --- Done ---
echo
echo "============================================"
echo " Setup complete. Next steps:"
echo "============================================"
echo
echo "  1. Exit this container:  exit"
echo "  2. Start OpenClaw:       docker compose up -d"
echo "  3. Open dashboard:       http://localhost:18789"
echo
echo "--------------------------------------------"
echo " Optional: fine-tune with CLI"
echo "--------------------------------------------"
echo
echo "  # Change default model"
echo "  openclaw config set agents.defaults.model \"anthropic/claude-opus-4.6\""
echo
echo "  # Enable Telegram"
echo "  openclaw config set channels.telegram.enabled true"
echo "  openclaw config set channels.telegram.botToken \"YOUR_TOKEN\""
echo
echo "  # Sandbox mode (non-main | all | off)"
echo "  openclaw config set agents.defaults.sandbox.mode \"non-main\""
echo
echo "  # View full config"
echo "  openclaw config get"
echo
