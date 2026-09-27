{
  description = "Brady Bhalla's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    {
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
          "brady@desktop" = mkHome {
            system = "x86_64-linux";
            homeModules = [
              ./modules/home/common.nix
              ./modules/home/extended-utils.nix
              ./modules/home/hyprland-desktop.nix
              ./modules/home/linux-utils.nix
            ];
          };

          "brady@laptop" = mkHome {
            system = "aarch64-darwin";
            homeModules = [
              ./modules/home/common.nix
              ./modules/home/extended-utils.nix
              ./modules/home/macos-utils.nix
            ];
          };
        };
    };
}
