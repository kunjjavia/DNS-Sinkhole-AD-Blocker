#!/bin/bash
# Path to your Tailscale folder (Update this!)
TS_DIR="/data/data/com.termux/files/home/tailscale_1.96.4_arm"

echo "🔑 Starting Independent Tailscale Session..."

# Kill any existing instance to ensure a clean start
sudo pkill tailscaled

# Start the daemon in the background
sudo $TS_DIR/tailscaled --tun=userspace-networking --statedir=$TS_DIR/tailscale-state --socket=$TS_DIR/tailscaled.sock &

# Wait for daemon to bind
sleep 3

# Bring up the tunnel
sudo $TS_DIR/tailscale --socket=$TS_DIR/tailscaled.sock up --accept-dns=false

echo "✅ Tailscale started in independent session."
