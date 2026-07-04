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
            { system, homeModule }:
            home-manager.lib.homeManagerConfiguration {
              pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
              };
              modules = [ homeModule ];
            };
        in
        {
          "bradybhalla@pc-brady" = mkHome {
            system = "x86_64-linux";
            homeModule = ./hosts/pc-brady/home.nix;
          };

          "bradybhalla@macbook-pro-brady" = mkHome {
            system = "aarch64-darwin";
            homeModule = ./hosts/macbook-pro-brady/home.nix;
          };

          "bradybhalla@vm-macbook-brady" = mkHome {
            system = "x86_64-linux";
            homeModule = ./hosts/vm-macbook-brady/home.nix;
          };
        };
    };
}
