{ config, pkgs, ... }:

{
  programs.virt-manager.enable = true;

  users.groups.libvirtd.members = ["cooke"];
 
  virtualisation.libvirtd.enable = true;

  virtualisation.spiceUSBRedirection.enable = true;

  users.users.cooke.extraGroups = [ "libvirtd" ];  
}
