{lib, pkgs, ...}:

{
 
  environment.systemPackages = with pkgs; [
    gamemode
    SDL2
  ];
  
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [
      libglvnd
      libGL
    ];
  };
  
  programs.gamemode = {
    enable = true;
    settings.general = {
      startscript = "/etc/gamemode_start.sh";
      endscript = "/etc/gamemode_end.sh";
    };
  };
  
  
  environment.etc."gamemode_start.sh".text = ''
    #!/usr/bin/env bash
    pkill -9 swayidle
    pkill -9 swaylock
  '';
  
  environment.etc."gamemode_end.sh".text = ''
    #!/usr/bin/env bash
    exec swayidle -w \
      timeout 300 'swaylock -f -c 000000' \
      timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
      before-sleep 'swaylock -f -c 000000'
  '';
  
  # Make scripts executable
  systemd.tmpfiles.rules = [
    "f /etc/gamemode_start.sh 0755 root root"
    "f /etc/gamemode_end.sh 0755 root root"
  ];
  
  
  services.udev.extraRules = ''
    SUBSYSTEM=="input", ATTRS{idVendor}=="10f5", ATTRS{idProduct}=="7016", MODE="0660", GROUP="input"
  '';

}
