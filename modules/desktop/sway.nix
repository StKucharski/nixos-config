{config, pkgs, lib, ...}:
{
  environment.systemPackages = with pkgs; [
     grim 
     slurp
     mako
     swayidle
     swaylock-effects
     foot
     networkmanager_dmenu
     swaybg
     wofi
     orchis-theme
     papirus-icon-theme
     gtk3
     gtk4
     (import ./sway_powerctl.nix {inherit pkgs; })
     waybar
     eww
     brightnessctl
     lxqt.lxqt-policykit
  ];
   
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.udisks2.enable = true;   
   
  #auto login
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "/bin/sh -c 'GTK_THEME=Orchis-Dark dbus-run-session sway'";
        user = "cooke";
      };
      default_session = initial_session;
    };
  };

  security.pam.loginLimits = [
  { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
  ];

  environment.etc."pam.d/swaylock".text = lib.mkForce ''
    # Account management
    account required pam_unix.so

    # Authentication management
    auth sufficient pam_fprintd.so timeout=1
    auth sufficient pam_unix.so try_first_pass
    auth required pam_deny.so

    # Password management
    password sufficient pam_unix.so nullok yescrypt

    # Session management
    session required pam_env.so conffile=/etc/pam/environment readenv=0
    session required pam_unix.so
    session required pam_limits.so
  '';

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';      

}
