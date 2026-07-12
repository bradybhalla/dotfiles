{
  description = "bradybhalla's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        "desktop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/desktop/configuration.nix ];
        };

        "vm-on-laptop" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs; };
          modules = [ ./hosts/vm-on-laptop/configuration.nix ];
        };
      };

      darwinConfigurations."laptop" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/laptop/configuration.nix ];
      };

      homeConfigurations =
        let
          mkHome =
            { system, homeModules }:
            home-manager.lib.homeManagerConfiguration {
              pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
              };
              modules = homeModules;
            };
        in
        {
          "bradybhalla@desktop" = mkHome {
            system = "x86_64-linux";
            homeModules = [
              ./modules/home/common.nix
              ./modules/home/extended-utils.nix
              ./modules/home/hyprland-desktop.nix
              ./modules/home/linux-apps.nix
            ];
          };

          "bradybhalla@laptop" = mkHome {
            system = "aarch64-darwin";
            homeModules = [
              ./modules/home/common.nix
              ./modules/home/extended-utils.nix
              ./modules/home/macos-utils.nix
            ];
          };

          "bradybhalla@vm-on-laptop" = mkHome {
            system = "aarch64-linux";
            homeModules = [
              ./modules/home/common.nix
              # ./modules/home/extended-utils.nix
              ./modules/home/hyprland-desktop.nix
              ./modules/home/linux-apps.nix
            ];
          };
        };
    };
}
