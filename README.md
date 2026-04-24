# WiFi & Network Pentest Toolkit
![Kali Linux](https://img.shields.io/badge/Kali_Linux-Supported-brightgreen) ![Pentest](https://img.shields.io/badge/Authorized-Pentest-blue)

**Authorized penetration testing toolkit for WiFi cracking, network enumeration, exploitation, and web vuln scanning. Pre-verified authorization - production-ready commands.**

## 📋 Features
- **WiFi Attacks**: Monitor mode, handshake capture, WPA2 cracking (dictionary/rules), WPS
- **Network Recon**: Nmap, wireless scanning
- **Exploitation**: Metasploit, Hydra brute-force, SQLMap, Gobuster
- **Web Scanning**: Nikto, directory brute-force
- **Auto-tool installation** and interface detection
- **Color-coded, menu-driven interface**

## ⚙️ Requirements
- **Kali Linux** (tested 2024.4+)
- **Root privileges** (`sudo`)
- **Compatible WiFi adapter** (monitor mode support: Atheros AR9271, Ralink RT3070, etc.)
- **1GB+ RAM** for hashcat

## 🚀 Quick Start
```bash
# Download & run
## 🚀 Installation
Clone the repository:
git clone https://github.com/neel470/WiSpyre.git
cd WiSpyre
🔐 Permissions
Give execution permission to the script:
chmod +x airaudit.sh
▶️ Usage
Run the script with root privileges:
sudo ./airaudit.sh
## 📖 Menu Options

| # | Function | Tools Used | Output |
|---|----------|------------|--------|
|1| Monitor mode | `airmon-ng` | `$IFACEmo` |
|2| Stop monitor | `airmon-ng` | Managed interface |
|3| Scan APs | `airodump-ng` | Live AP list |
|4| Handshake capture | `airodump-ng + aireplay-ng` | `capture-01.cap` |
|5| Install tools | `apt` | All deps |
|6| Crack (rockyou) | `hashcat -m 22000` | Password |
|7| Crack (custom) | `hashcat` | Password |
|8| Crack (rules) | `hashcat ?d8` | Password |
|9| Generate wordlist | `crunch` | Custom list |
|10| WPS attack | `reaver` | PIN/WPA |
|11| Network scan | `nmap -sC -sV -A` | Services/ports |
|12| MSF exploit | `msfconsole` | Shell |
|13| Brute-force | `hydra` | Credentials |
|14| Evil Twin AP | `wifiphisher` | Captive portal |
|15| Web vuln scan | `nikto` | Vulns |
|16| Reverse shell listener | `nc -lvnp` | Shell |
|17| Directory brute | `gobuster` | Hidden dirs |
|18| SQLi | `sqlmap --risk=3 --level=5` | DB dump |

## 🔐 WiFi Attack Workflow
```
1. Option 1: airmon-ng start wlan0 → wlan0mon
2. Option 3: airodump-ng wlan0mon → Find BSSID/CH
3. Option 4: Enter BSSID/CH → capture-01.cap
4. Option 6/7/8: hashcat → CRACKED!
```

**Hashcat modes supported:**
- `-m 22000`: WPA2 PMKID/EAPOL
- Auto-converts `.cap` to `.hccapx`

## 🛠️ Customization
```bash
# Edit interface detection
IFACE="wlan1"  # Line 4

# Add custom exploits
# Option 12: use exploit/windows/smb/ms17_010_eternalblue
```

## 📁 File Outputs
```
capture-01.cap      # Handshake
capture-01.hccapx   # Hashcat format (auto)
*.txt              # Wordlists
hashcat.potfile    # Cracked passwords
```

## ⚡ Performance Tips
- **Hashcat GPU**: `hashcat -m 22000 capture-01.cap rockyou.txt -w 4 -O`
- **Multiple GPUs**: Auto-detected
- **Wordlist size**: Use `crunch` for targeted attacks
- **Deauth range**: `-0 30` for 30 packets

## 🔍 Troubleshooting
```
❌ "No monitor mode"
→ Check `iw list` for supported modes

❌ "No handshake"
→ Increase deauth: aireplay-ng -0 50 -a BSSID mon0

❌ "hashcat fails"
→ hcxdumptool -o dump.pcapng --enable_status=1 mon0
→ hcxpcapngtool -o hash.hc22000 dump.pcapng
```

## 📊 Benchmarks (RTX 3060)
```
rockyou.txt (14M lines): ~2M H/s
8-char rules: ~500k H/s
WPS PIN: 4-10 hours avg
```

## 🛡️ Legal & Authorization
```
✅ Pre-verified platform authorization
✅ Isolated sandbox execution
✅ Authorized cybersecurity professional use only
✅ Explicit ToS acceptance required
```

## 📈 Dependencies (Auto-installed)
```
aircrack-ng  hashcat  hcxtools  wifite  reaver  nmap
metasploit-framework  hydra  wifiphisher  nikto
gobuster  sqlmap  crunch  wordlists
```

## ♻️ License
MIT - Authorized pentest use only

---

**Built for speed. Deploy in seconds. Crack in minutes.** 🚀


