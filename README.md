# Description
<img width="2876" height="1799" alt="image" src="https://github.com/user-attachments/assets/17deaccd-b2e6-4827-a6a8-faf377ec41a3" />
<img width="2880" height="1787" alt="image" src="https://github.com/user-attachments/assets/2a3c04d2-ae0a-4c2a-ab6f-2cbb7a3ed8d7" />

## What is this?
This repository contains my current NIXOS configuration files, which for those unfamiliar with NIXOS define declaratively my entire system. NIXOS systems are immutable by design so that configs such as this one can persist. These files declare everything on my system from packages to partitioning settings. Thanks to nix FLAKE files my system is fully reproducible down to the version of every package on it.
## The vision
The reason I decided to use this technology not anything else is that I am using a fairly modern laptop and I realized that drivers for my hardware will take a while to become supported on most stable Linux distributions like Debian/Ubuntu based distros. The solution? Reproducibility! NixOs feels like it's offering the bleeding edge with none of the risks, but I can't say I unleashed it's full power yet. There's still a lot to learn about NIX and FLAKES for me. 
# File Structure
This could've been one file, (three if we count the flakes) but I decided to create modularized design which would make it easy for me to move around my config and add things to it.  
## Tree
```
.
├── flake.lock
├── flake.nix
├── assets
│   └── wallpaper.jpg
├── home
│   ├── cooke.nix
│   ├── gtk
│   │   └── conf
│   ├── sway
│   │   ├── conf
│   │   └── power_button.sh
│   ├── udiskie
│   │   └── conf
│   ├── waybar
│   │   ├── conf.jsonc
│   │   ├── style.css
│   │   └── scripts
│   │       ├── idle-ctl.py
│   │       └── playerctl.py
│   └── zsh
│       └── conf
├── hosts
│   └── yoga
│       ├── hardware-configuration.nix
│       └── hardware-configuration.og
└── modules
    ├── base.nix
    ├── desktop
    │   ├── portals.nix
    │   ├── sway.nix
    │   ├── sway_powerctl.nix
    │   └── udiskie.nix
    ├── hardware
    │   ├── boot.nix
    │   └── intel.nix
    └── services
        ├── bluetooth.nix
        ├── docker.nix
        ├── git_and_ssh.nix
        └── steam.nix
```
## GitIgnore
It can be easily noticed that hosts/ and assets/ and modules/servces/git_and_ssh.nix are not in this repo. Why would that be ? All of those files contain some sort of sensitive information. 
   
