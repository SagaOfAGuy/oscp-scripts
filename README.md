# OSCP Scripts
Scripts for OSCP recon and privesc



## Initial-Enum.sh
Script that runs an NMAP scan first, and pipes ports into `autorecon` in case `autorecon` misses ports from the start
### Usage
1. Make script executable
```bash
chmod +x intial-enum.sh
```
2. Move to `/usr/local/bin` to run the script globally from terminal
```bash
sudo mv initial-enum.sh initial-enum
sudo mv initual-enum /usr/local/bin/initial-enum
```
3. Run script by providing IP address
```bash
initial-enum 192.168.1.210
```

## Windows-AD-Privesc-Tools.py
