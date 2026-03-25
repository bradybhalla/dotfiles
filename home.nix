{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "bradybhalla";
  homeDir = "/Users/bradybhalla";
  dotfilesRepoDir = "${homeDir}/Documents/dotfiles";
in
{
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "25.05";

  home.sessionPath = [
    "/opt/homebrew/bin"
  ];

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
    skhd

    tree
    imagemagick
    wget
    curl
    croc
    rlwrap
    pandoc
    jq
    ffmpeg
    gcc
    cmake
    glibtool
    ispell

    uv
    nodejs
    ghc
    stack
    rustup
    typst
    opam
    nixfmt

    claude-code
    (llm.withPlugins {
      llm-gemini = true;
      llm-cmd = true;
    })

    nerd-fonts.meslo-lg
  ];

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
      firefox = "open -a Firefox\\ Developer\\ Edition";
    };
    initContent = lib.mkBefore ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
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
    };
}
