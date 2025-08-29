{config, pkgs, lib, ...}:
{
  xdg.portal = {
    enable = true;
    wlr.enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = [ "wlr" ];
      };
    };
  };

  services.flatpak.enable = true;
}
