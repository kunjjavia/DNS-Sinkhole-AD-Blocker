#!/bin/bash
# Path to the control file
CHARGE_PATH="/sys/class/power_supply/battery/charging_enabled"

while true; do
    # Get current capacity
    CAPACITY=$(cat /sys/class/power_supply/battery/capacity)
    # Get current status (1=Enabled, 0=Disabled)
    STATUS=$(cat $CHARGE_PATH)

    # If capacity >= 80 and currently charging (1), turn it off (0)
    if [ "$CAPACITY" -ge 80 ] && [ "$STATUS" -eq 1 ]; then
        echo 0 | sudo tee $CHARGE_PATH
        echo "🔋 Battery at $CAPACITY%. Charging disabled."

    # If capacity <= 40 and currently disabled (0), turn it on (1)
    elif [ "$CAPACITY" -le 40 ] && [ "$STATUS" -eq 0 ]; then
        echo 1 | sudo tee $CHARGE_PATH
        echo "🔌 Battery at $CAPACITY%. Charging enabled."
    fi

    echo "[$(date +%T)] Battery: $CAPACITY% | Charging: $STATUS"

    # Wait 60 seconds before checking again
    sleep 350
done
