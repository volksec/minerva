#!/bin/bash

echo -e "
\x1b[31m
 ███▄ ▄███▓ ██▓ ███▄    █ ▓█████  ██▀███   ██▒   █▓ ▄▄▄      
▓██▒▀█▀ ██▒▓██▒ ██ ▀█   █ ▓█   ▀ ▓██ ▒ ██▒▓██░   █▒▒████▄    
▓██    ▓██░▒██▒▓██  ▀█ ██▒▒███   ▓██ ░▄█ ▒ ▓██  █▒░▒██  ▀█▄  
▒██    ▒██ ░██░▓██▒  ▐▌██▒▒▓█  ▄ ▒██▀▀█▄    ▒██ █░░░██▄▄▄▄██ 
▒██▒   ░██▒░██░▒██░   ▓██░░▒████▒░██▓ ▒██▒   ▒▀█░   ▓█   ▓██▒
░ ▒░   ░  ░░▓  ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒▓ ░▒▓░   ░ ▐░   ▒▒   ▓▒█░
░  ░      ░ ▒ ░░ ░░   ░ ▒░ ░ ░  ░  ░▒ ░ ▒░   ░ ░░    ▒   ▒▒ ░
░      ░    ▒ ░   ░   ░ ░    ░     ░░   ░      ░░    ░   ▒   
       ░    ░           ░    ░  ░   ░           ░        ░  ░
                                               ░              
By @volksec
\x1b[0m
"

TARGET=$1
OUTPUT_DIR="recon_$TARGET"
NMAP_SCAN_OPTIONS="-sC -sV"
GOOGLE_DORK="inurl:admin OR inurl:login"
OSINT_TOOLS=("theHarvester" "amass" "recon-ng" "spiderfoot")
PEN_TEST_TOOLS=("nikto" "dirb" "wpscan" "enum4linux" "snmpwalk" "nmap")

if [ -z "$TARGET" ]; then
    echo "Usage: $0 <target>"
    exit 1
fi

mkdir -p $OUTPUT_DIR

run_nmap() {
    echo "[*] Running Nmap for $TARGET"
    nmap $NMAP_SCAN_OPTIONS $TARGET -oN $OUTPUT_DIR/nmap_scan.txt
}

run_google_dorking() {
    echo "[*] Running Google Dorking"
    curl -s "https://www.google.com/search?q=$GOOGLE_DORK+$TARGET" > $OUTPUT_DIR/google_dorking_results.html
}

run_osint() {
    echo "[*] Running OSINT tools"
    for tool in "${OSINT_TOOLS[@]}"; do
        if command -v $tool &> /dev/null; then
            echo "[*] Running $tool"
            case $tool in
                theHarvester)
                    theHarvester -d $TARGET -b all -l 500 -f $OUTPUT_DIR/theHarvester_results.html
                    ;;
                amass)
                    amass enum -d $TARGET -o $OUTPUT_DIR/amass_results.txt
                    ;;
                recon-ng)
                    recon-ng -r $TARGET -o $OUTPUT_DIR/recon_ng_results.txt
                    ;;
                spiderfoot)
                    spiderfoot -s $TARGET -o $OUTPUT_DIR/spiderfoot_results.html
                    ;;
            esac
        else
            echo "[!] $tool not found, skipping."
        fi
    done
}

run_pentest() {
    echo "[*] Running penetration testing and enumeration tools"
    for tool in "${PEN_TEST_TOOLS[@]}"; do
        if command -v $tool &> /dev/null; then
            echo "[*] Running $tool"
            case $tool in
                nikto)
                    nikto -h $TARGET -o $OUTPUT_DIR/nikto_results.txt
                    ;;
                dirb)
                    dirb http://$TARGET -o $OUTPUT_DIR/dirb_results.txt
                    ;;
                wpscan)
                    wpscan --url http://$TARGET -o $OUTPUT_DIR/wpscan_results.txt
                    ;;
                enum4linux)
                    enum4linux -a $TARGET > $OUTPUT_DIR/enum4linux_results.txt
                    ;;
                snmpwalk)
                    snmpwalk -v2c -c public $TARGET > $OUTPUT_DIR/snmpwalk_results.txt
                    ;;
                nmap)
                    echo "[*] Nmap already executed."
                    ;;
            esac
        else
            echo "[!] $tool not found, skipping."
        fi
    done
}

run_nmap
run_google_dorking
run_osint
run_pentest

echo "[*] Reconnaissance and penetration testing completed. Results stored in $OUTPUT_DIR."

