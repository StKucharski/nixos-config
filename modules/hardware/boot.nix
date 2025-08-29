{ config, pkgs, ... }:
{
 
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.consoleMode = "max";
  boot.loader.systemd-boot.editor = false;
  boot.loader.timeout = 2;
  
  boot.initrd.systemd.enable = true;
  
  boot.plymouth = {
    enable = true;
    theme = "bgrt";
  };
  
  boot.kernelParams = [ "quiet" "loglevel=3" "nowatchdog" "fastboot" ];

}
