{
  config,
  lib,
  pkgs,
  linkHere,
  ...
}:
let
  username = "bradybhalla";
  dotfilesRepoDir = "${config.home.homeDirectory}/dotfiles";
in
{
  home.username = username;
  home.homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
  home.stateVersion = "25.05";

  # Shared helpers, injected into every home module via the module system's
  # fixpoint so they can depend on config.home.homeDirectory.
  _module.args.linkHere =
    path: config.lib.file.mkOutOfStoreSymlink "${dotfilesRepoDir}/dotfiles/${path}";

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
    tree
    wget
    curl
    # croc # TODO broken: broken right now but enable later
    rlwrap
    jq
    tree-sitter
    gcc

    nerd-fonts.meslo-lg
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings.user = {
      name = "Brady Bhalla";
      email = "34150846+bradybhalla@users.noreply.github.com";
    };
  };

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

  home.file = {
    ".config/nvim".source = linkHere ".config/nvim";
    ".tmux.conf".source = linkHere ".tmux.conf";
    ".config/alacritty".source = linkHere ".config/alacritty";
    ".p10k.zsh".source = linkHere ".p10k.zsh";
    ".spacemacs".source = linkHere ".spacemacs";
  };
}
