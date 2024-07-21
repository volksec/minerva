# Minerva
AutoRecon & Pentest Script By @volksec

![Screenshot](https://github.com/volksec/minerva/blob/main/example.png?raw=true)

# About

This script automates the reconnaissance and penetration testing process for a given target. It uses various tools to perform Nmap scanning, Google Dorking, OSINT gathering, and penetration testing and enumeration.

## Features

- **Nmap Scanning**: Performs Nmap scans with service and version detection.
- **Google Dorking**: Searches for potential admin or login pages using Google Dorking.
- **OSINT Gathering**: Uses tools like theHarvester, amass, recon-ng, and spiderfoot to gather open-source intelligence.
- **Penetration Testing and Enumeration**: Utilizes tools like nikto, dirb, wpscan, enum4linux, and snmpwalk.

## Requirements

Ensure the following tools are installed on your system:

- `nmap`
- `curl`
- `theHarvester`
- `amass`
- `recon-ng`
- `spiderfoot`
- `nikto`
- `dirb`
- `wpscan`
- `enum4linux`
- `snmpwalk`

## Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/volksec/minerva.git
    cd minerva
    ```

2. Make the script executable:

    ```bash
    chmod +x minerva.sh
    ```

3. Run the script with the target domain or IP:

    ```bash
    ./minerva.sh <target>
    ```
    
4. Example:

    ```bash
    ./minerva.sh example.com
    ```

### Contributing

Fell free to submit issues or pull requests if you find any bugs or have suggestions for improvements.

