{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home/common.nix
    ../../modules/home/extended-utils.nix
    ../../modules/home/macos-utils.nix
  ];
}
