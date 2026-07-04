{
  config,
  pkgs,
  lib,
  username,
  dotfilesRepoDir,
  ...
}:
{
  home.username = username;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
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
    # croc # TODO broken: broken right now but enable later
    rlwrap
    jq
    tree-sitter

    nerd-fonts.meslo-lg
    imagemagick
    pandoc
    ffmpeg
    ispell
    texliveFull
    ollama

    cmake
    glibtool
    glfw
    clang-tools

    uv
    nodejs
    rustup
    typst
    opam
    nixfmt
    maven
    javaPackages.compiler.temurin-bin.jre-21
    hugo

    claude-code
    alacritty
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
      linkHere = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesRepoDir}/dotfiles/${path}";
    in
    {
      ".config/nvim".source = linkHere ".config/nvim";
      ".tmux.conf".source = linkHere ".tmux.conf";
      ".config/alacritty".source = linkHere ".config/alacritty";
      ".p10k.zsh".source = linkHere ".p10k.zsh";
      ".spacemacs".source = linkHere ".spacemacs";
      ".newsboat/config".source = linkHere ".newsboat/config";
    };
}
