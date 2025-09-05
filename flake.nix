{
  description = "My personal NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.yoganix = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/yoga/hardware-configuration.nix
          ./modules/base.nix
          ./modules/hardware/boot.nix
          ./modules/hardware/intel.nix
	  ./modules/desktop/sway.nix
          ./modules/desktop/udiskie.nix
          ./modules/desktop/portals.nix
          ./modules/services/steam.nix
          ./modules/services/git_and_ssh.nix
          ./modules/services/bluetooth.nix
          ./modules/services/docker.nix
          ./modules/services/virt.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.users.cooke = import ./home/cooke.nix;
            home-manager.backupFileExtension = "backup";
          }
        ];
      };
    };
}
