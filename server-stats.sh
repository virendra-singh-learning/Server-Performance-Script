#!/bin/bash

# CPU Usage

echo "====== CPU Usage ======"

CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'%' -f1)
CPU_USAGE=$(echo "100 - $CPU_IDLE" | bc)
echo "Total CPU Usage: $CPU_USAGE%"

# Memory Usage

echo -e "\n====== Memory Usage ======"

MEM=$(free -m | awk '/Mem:/ {print $2, $3, $4}')
TOTAL=$(echo $MEM | awk '{print $1}')
USED=$(echo $MEM | awk '{print $2}')
FREE=$(echo $MEM | awk '{print $3}')
PERCENT=$(echo "scale=2; $USED / $TOTAL * 100" | bc)
echo "Total: ${TOTAL} MB | Used: ${USED} MB | Free: ${FREE} MB | Usage: ${PERCENT}%"


# Disk Usage

echo -e "\n====== Disk Usage ======"

df -h / | awk 'NR==2 {print "Total: "$2" | Used: "$3" | Free: "$4" | Usage: "$5}'


# Top 5 CPU processes

echo -e "\n====== Top 5 Processes by CPU Usage ======"

ps -eo pid,comm,%cpu --sort=-%cpu | head -6


# Top 5 Memory processes

echo -e "\n====== Top 5 Processes by Memory Usage ======"

ps -eo pid,comm,%mem --sort=-%mem | head -6

# OS Version

echo -e "\n====== OS Version ======"

cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2

# Uptime

echo -e "\n====== Uptime ======"

uptime -p

# Load Avarage

echo -e "\n====== Load Avarage ======"

uptime | awk -F'load average:' '{ print $2 }'

#Logged in User

echo -e "\n====== Logged in Users ======"

who
