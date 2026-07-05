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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nix-darwin,
      ...
    }:
    {
      nixosConfigurations = {
        "pc-brady" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/pc-brady/configuration.nix ];
        };

        "vm-macbook-brady" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ ./hosts/vm-macbook-brady/configuration.nix ];
        };

        "vm-pc-brady" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/vm-macbook-brady/configuration.nix ];
        };
      };

      darwinConfigurations."macbook-pro-brady" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/macbook-pro-brady/configuration.nix ];
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
          "bradybhalla@pc-brady" = mkHome {
            system = "x86_64-linux";
            homeModules = [
              ./modules/home/common.nix
              ./modules/home/extended-utils.nix
              ./modules/home/desktop.nix
            ];
          };

          "bradybhalla@macbook-pro-brady" = mkHome {
            system = "aarch64-darwin";
            homeModules = [
              ./modules/home/common.nix
              ./modules/home/extended-utils.nix
              ./modules/home/macos-utils.nix
            ];
          };

          "bradybhalla@vm-macbook-brady" = mkHome {
            system = "aarch64-linux";
            homeModules = [
              ./modules/home/common.nix
              # ./modules/home/extended-utils.nix
              ./modules/home/desktop.nix
            ];
          };

          "bradybhalla@vm-pc-brady" = mkHome {
            system = "x86_64-linux";
            homeModules = [
              ./modules/home/common.nix
              # ./modules/home/extended-utils.nix
              ./modules/home/desktop.nix
            ];
          };
        };
    };
}
