{
  description = "Brady Bhalla's dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    streamdeck = {
      url = "git+ssh://git@100.121.252.21:2204/brady/streamdeck.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      streamdeck,
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
              streamdeck.homeManagerModules.default
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
