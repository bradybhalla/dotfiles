{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "bradybhalla";
  homeDir = "/home/bradybhalla";
  dotfilesRepoDir = "${homeDir}/Documents/dotfiles";
in
{
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "25.05";

  home.sessionPath = [ ];

  home.packages = with pkgs; [
    neovim
    tmux
    zsh-powerlevel10k
    zoxide
    fzf
    ripgrep
    fd
    htop
    lazygit
    git
    tree
    wget
    curl
    croc
    rlwrap
    jq
    tree-sitter

    nerd-fonts.meslo-lg
    imagemagick
    pandoc
    ffmpeg
    ispell
    texliveMedium

    cmake
    gcc
    glibtool

    uv
    nodejs
    rustup
    typst
    opam
    nixfmt
    maven
    javaPackages.compiler.temurin-bin.jre-21

    claude-code
    alacritty

    # waybar and dependencies
    waybar
    playerctl
    brightnessctl
    networkmanagerapplet

    (haskellPackages.ghcWithPackages (
      hpkgs: with hpkgs; [
        lacroix
      ]
    ))

  ];

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/.config/hypr/ocean-background.jpg"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "~/.config/hypr/ocean-background.jpg";
        }
      ];
      splash = false;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk.enable = true;
  gtk.gtk4.theme = null;

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    history = {
      size = 20000;
      save = 20000;
    };
    shellAliases = {
      ls = "ls --color=auto";
      lg = "lazygit";
      # firefox = "open -a Firefox\\ Developer\\ Edition"; # only on Mac
      titan = "ssh -t bbhalla@titan.caltech.edu \"~/run-nix.sh\""; # TODO remove July 2026
    };
    initContent = lib.mkBefore ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        hide_env_diff = true;
      };
    };
  };

  programs.fzf.enable = true;

  programs.zoxide = {
    enable = true;
    options = [
      "--cmd"
      "cd"
    ];
  };

  programs.opam.enable = true;

  home.file =
    let
      # link everything directly for quicker changes
      linkHere = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesRepoDir}/dotfiles/${path}";
    in
    {
      ".config/nvim".source = linkHere ".config/nvim";
      ".tmux.conf".source = linkHere ".tmux.conf";
      ".config/alacritty".source = linkHere ".config/alacritty";
      ".aerospace.toml".source = linkHere ".aerospace.toml";
      ".config/skhd/skhdrc".source = linkHere ".config/skhd/skhdrc";
      ".p10k.zsh".source = linkHere ".p10k.zsh";
      ".spacemacs".source = linkHere ".spacemacs";
      ".newsboat/config".source = linkHere ".newsboat/config";
      ".config/hypr/catppuccin-macchiato.lua".source = linkHere ".config/hypr/catppuccin-macchiato.lua";
      ".config/hypr/hyprland.lua".source = linkHere ".config/hypr/hyprland.lua";
      ".config/hypr/hyprlock.conf".source = linkHere ".config/hypr/hyprlock.conf";
      ".config/hypr/hyprtoolkit.conf".source = linkHere ".config/hypr/hyprtoolkit.conf";
      ".config/hypr/ocean-background.jpg".source = linkHere ".config/hypr/ocean-background.jpg";
      ".config/waybar".source = linkHere ".config/waybar";
    };
}
