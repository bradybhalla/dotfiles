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
      };

      darwinConfigurations."macbook-pro-brady" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/macbook-pro-brady/configuration.nix ];
      };

      homeConfigurations = {
        "bradybhalla@pc-brady" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            username = "bradybhalla";
            dotfilesRepoDir = "/home/bradybhalla/Documents/dotfiles";
          };
          modules = [
            ./modules/home/common.nix
            ./modules/home/extended-utils.nix
            ./modules/home/desktop.nix
          ];
        };

        "bradybhalla@macbook-pro-brady" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            username = "bradybhalla";
            dotfilesRepoDir = "/Users/bradybhalla/Documents/dotfiles";
          };
          modules = [
            ./modules/home/common.nix
            ./modules/home/extended-utils.nix
            ./modules/home/macos-utils.nix
          ];
        };

        "bradybhalla@vm-macbook-brady" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "aarch64-linux";
            config.allowUnfree = true;
          };
          extraSpecialArgs = {
            username = "bradybhalla";
            dotfilesRepoDir = "/home/bradybhalla/Documents/dotfiles";
          };
          modules = [
            ./modules/home/common.nix
            ./modules/home/extended-utils.nix
            ./modules/home/desktop.nix
          ];
        };

      };
    };
}
