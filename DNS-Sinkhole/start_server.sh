#!/bin/bash
echo "--- 🚀 Starting Home Lab (Final Stable) ---"

# 1. Kill SELinux
sudo setenforce 0

# 2. Port Bridge
sudo /system/bin/iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-port 5353
sudo /system/bin/iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-port 5353

# 3. DOWNLOAD LISTS
echo "📥 Downloading Blocklists..."
cd ~
curl -k -L -s -o list1.txt "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt"
curl -k -L -s -o list2.txt "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
curl -k -L -s -o list3.txt "https://big.oisd.nl"
curl -k -L -s -o list4.txt "https://easylist-downloads.adblockplus.org/easylistindia.txt"

cat list1.txt list2.txt list3.txt list4.txt > super_blocklist.txt
rm list1.txt list2.txt list3.txt list4.txt

# 4. START PYTHON SERVER
echo "🐍 Starting Update Server..."
pkill -f "python3 -m http.server"
nohup python3 -m http.server 9000 > /dev/null 2>&1 &

# 5. WATCHDOG LOOP
while true; do
    echo "🛡️  Starting AdGuard Home..."
    cd ~/AdGuardHome
    export SSL_CERT_FILE=/data/data/com.termux/files/usr/etc/tls/cert.pem
    sudo -E ./AdGuardHome --host 0.0.0.0
    
    echo "⚠️  Crashed! Reviving in 3s..."
    sleep 3
    # Re-apply bridge just in case
    sudo /system/bin/iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-port 5353
    sudo /system/bin/iptables -t nat -A PREROUTING -p tcp --dport 53 -j REDIRECT --to-port 5353
done
