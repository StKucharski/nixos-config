{config, lib, pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;
  
  networking.hostName = "yoganix";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    kbd
  ];

  fonts.packages = with pkgs; [
    font-awesome
    terminus_font
    ibm-plex
    nerd-fonts.jetbrains-mono 
  ];
  
  security = {
    sudo.wheelNeedsPassword = true;
    rtkit.enable = true;
  };

  console.useXkbConfig = true;  
  
  services = {
    dbus.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    printing.enable = true;

    libinput.enable = true;

    xserver.xkb = {
      layout = "pl";
    };

    fprintd.enable = true;
  };  
  
  programs = {
    zsh.enable = true; 
    firefox.enable = true;
  };

  users.users.cooke = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };
  
  system.stateVersion = "25.05";
}

