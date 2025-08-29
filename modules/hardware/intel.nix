{ config, pkgs, ... }:
{
  services.upower.enable = true;
  powerManagement.enable = true;
  services.thermald.enable = true;
  
  powerManagement.cpuFreqGovernor = "schedutil"; #"powersave"; "performance";

  services.power-profiles-daemon.enable = true;
  
  boot.kernelParams = [
    "i915.enable_fbc=1"    # Framebuffer compression, saves power
    "i915.enable_psr=1"    # Panel Self Refresh for battery savings
    #the following two are a gamble
    "i915.enable_dc=2"     #deep colors     
    "i915.enable_dpcd_backlight=1" #wayland keyboard backlight tweak
  ];

  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];

  #great for monitoring and tuning
  environment.systemPackages = with pkgs; [ powertop ];

}
