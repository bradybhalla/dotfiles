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
        "pc" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/pc/configuration.nix ];
        };

        "macbook-vm" = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [ ./hosts/macbook-vm/configuration.nix ];
        };
      };

      darwinConfigurations."macbook-pro" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [ ./hosts/mac/configuration.nix ];
      };

      homeConfigurations = {
        "bradybhalla@pc" = home-manager.lib.homeManagerConfiguration {
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
            ./modules/home/desktop.nix
          ];
        };

        "bradybhalla@macbook-pro" = home-manager.lib.homeManagerConfiguration {
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
            ./modules/home/mac.nix
          ];
        };

        "bradybhalla@nixos-vm-on-macbook" = home-manager.lib.homeManagerConfiguration {
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
            ./modules/home/desktop.nix
          ];
        };

      };
    };
}
