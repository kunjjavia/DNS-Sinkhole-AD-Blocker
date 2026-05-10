# Moto G5 Home Lab: AdGuard + Tailscale + Kernel Battery Management

This repository contains the orchestration scripts for a repurposed, rooted Moto G5 serving as a 24/7 network-wide DNS filter and VPN gateway.

## 🚀 Overview
A low-power home server solution built inside Termux, featuring automated startup, remote mesh networking, and hardware-level battery protection.

### Core Services:
- **AdGuard Home:** DNS-based ad and tracker blocking.
- **Tailscale:** Private mesh VPN for secure remote access.
- **Battery Watchdog:** A kernel-direct monitor to manage device longevity.

---

## 🛠 Project Structure

- `start_server.sh`: Self-healing AdGuard Home process manager.
- `start_tailscale.sh`: Tailscale initialization with absolute path persistence.
- `battery_limit.sh`: **Kernel-Direct** monitor that reads `/sys/class/power_supply/` to track battery health without relying on the unstable Android API.
- `start.sh`: The master orchestrator (located in `~/.termux/boot/`) that launches all services into a labeled `tmux` session at boot.

---

## 🔧 Installation & Deployment

1. **Prerequisites:**
   - Rooted Android device with Termux & Termux:Boot installed.
   - `pkg install git tmux tsu sudo termux-api`

2. **Clone & Setup:**
   ```bash
   git clone [https://github.com/kunjjavia/DNS-Sinkhole-AD-Blocker.git](https://github.com/kunjjavia/DNS-Sinkhole-AD-Blocker.git)
   cd DNS-Sinkhole-AD-Blocker
   chmod +x *.sh
