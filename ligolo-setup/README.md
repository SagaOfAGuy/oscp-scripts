# Ligolo-setup
Script that downloads and starts ligolo-ng tool for network pivoting. Provides steps on how to setup a network pivot.

## Usage
### 1. Make script executable
```bash
chmod +x ligolo-setup
```
### 2. Move script to executable PATH
```bash
sudo mv ligolo-setup /usr/local/bin
```
### 3. Run the script.
```bash
ligolo-setup <Target IP> <CIDR network you want to pivot to>

# Example usage:
ligolo-setup 192.168.10.120 172.16.120.0
```
- You would provide 2 parameters; the IP of the machine with dual Network devices, and the internal network we want to pivot to as seen here: `ligolo-setup <Target IP> <CIDR network you want to pivot to>`
- For example, we have a target that has IP address **192.168.10.120** (that is accessible from our machine), but it also has another network device where its IP address is **172.16.120.120** (internal, and not accessible from our machine), and we want to pivot to the **172.16.120.0/24** network.
- In that case we can run `ligolo-setup 192.168.10.120 172.16.120.0` and we can omit the `/24` portion as that is already hardcoded into this script. 

![Alt text](image.png)
