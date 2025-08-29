{config, pkgs, ...}:
{
  hardware.bluetooth.enable = true;

  services.blueman.enable = true;  # GUI tools for managing devices
}
