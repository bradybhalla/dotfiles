{
  config,
  pkgs,
  dotfilesRepoDir,
  ...
}:
{
  programs.zsh.shellAliases = {
    firefox = "open -a Firefox\\ Developer\\ Edition";
  };

  home.file =
    let
      linkHere = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesRepoDir}/dotfiles/${path}";
    in
    {
      ".aerospace.toml".source = linkHere ".aerospace.toml";
      ".config/skhd/skhdrc".source = linkHere ".config/skhd/skhdrc";
    };
}
