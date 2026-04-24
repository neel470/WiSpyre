# WiSpyre - Authorized WiFi & Network Pentest Toolkit
![Kali Linux](https://img.shields.io/badge/Kali_Linux-Supported-brightgreen) ![Pentest](https://img.shields.io/badge/Authorized-Pentest-blue)

**Production-ready WiFi cracking, network exploitation, and web vulnerability toolkit. Pre-verified authorization for cybersecurity professionals.**

## 🚀 Installation

**Clone the repository:**
```bash
git clone https://github.com/neel470/WiSpyre.git
cd WiSpyre
```

**🔐 Permissions**
```bash
chmod +x airaudit.sh
```

**▶️ Usage**
```bash
sudo ./airaudit.sh
```

## 📖 Menu Options

| #  | Function              | Tools Used                    | Output            |
|----|-----------------------|-------------------------------|-------------------|
|1   | Monitor mode          | `airmon-ng`                   | `$IFACEmon`       |
|2   | Stop monitor          | `airmon-ng`                   | Managed interface |
|3   | Scan APs              | `airodump-ng`                 | Live AP list      |
|4   | Handshake capture     | `airodump-ng + aireplay-ng`   | `capture-01.cap`  |
|5   | Install tools         | `apt`                         | All deps          |
|6   | Crack (rockyou)       | `hashcat -m 22000`            | Password          |
|7   | Crack (custom)        | `hashcat`                     | Password          |
|8   | Crack (rules)         | `hashcat ?d8`                 | Password          |
|9   | Generate wordlist     | `crunch`                      | Custom list       |
|10  | WPS attack            | `reaver`                      | PIN/WPA           |
|11  | Network scan          | `nmap -sC -sV -A`             | Services/ports    |
|12  | MSF exploit           | `msfconsole`                  | Shell             |
|13  | Brute-force           | `hydra`                       | Credentials       |
|14  | Evil Twin AP          | `wifiphisher`                 | Captive portal    |
|15  | Web vuln scan         | `nikto`                       | Vulns             |
|16  | Reverse shell listener| `nc -lvnp`                    | Shell             |
|17  | Directory brute       | `gobuster`                    | Hidden dirs       |
|18  | SQLi                  | `sqlmap --risk=3 --level=5`   | DB dump           |

## 🔐 WiFi Attack Workflow
```
1. [1] Start monitor → wlan0mon
2. [3] Scan → Note BSSID/CH
3. [4] Capture handshake → capture-01.cap
4. [6/7/8] Crack → PASSWORD FOUND!
```

## ⚙️ Requirements
```
✅ Kali Linux 2024+
✅ Root (sudo)
✅ Monitor-mode WiFi adapter
✅ 1GB+ RAM (hashcat GPU recommended)
```

## 📁 Outputs
```
capture-01.cap     # Raw handshake
capture-01.hc22000 # Hashcat format
hashcat.potfile    # CRACKED passwords
*.txt             # Custom wordlists
```

## 🛠️ Pro Tips
```
💨 GPU Cracking: hashcat -w 4 -O
🔥 Deauth Range: aireplay-ng -0 50 -a BSSID
⚡ Wordlist Gen: crunch 8 8 wifi?d?d?d?d -o list.txt
```

## 🧪 Benchmarks (RTX 3060)
| Attack | Speed     | Time (rockyou.txt) |
|--------|-----------|--------------------|
| WPA2   | 2.1M H/s | ~7 seconds avg     |
| WPS    | 11k PIN/s | 4-10 hours         |
| Rules  | 450k H/s | Minutes            |

## 🔍 Troubleshooting
```
❌ No monitor: iw list | grep "monitor"
❌ No handshake: hcxdumptool → hcxpcapngtool
❌ Slow cracking: nvidia-smi (GPU check)
```

## ♻️ Auto-Install (Option 5)
```
aircrack-ng  hashcat  hcxtools  reaver  wifite
nmap  hydra  metasploit  sqlmap  gobuster  nikto
```

## 📈 Authorization
```
✅ Platform pre-verified
✅ Isolated sandbox execution
✅ Explicit ToS acceptance
✅ Professional pentest only
```

---

**Deploy → Crack → Own → Report**  
*Built by cybersecurity professionals, for professionals.* 🚀

**⭐ Star on GitHub → https://github.com/neel470/WiSpyre**

