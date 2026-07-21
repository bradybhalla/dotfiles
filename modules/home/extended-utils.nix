# extra dev/build tooling plus Claude Code setup

{ pkgs, linkHere, ... }:
{
  home.packages = with pkgs; [
    gcc
    # croc # TODO broken: broken right now but enable later
    rlwrap
    jq
    tree
    sqlite
    gnumake
    cmake

    imagemagick
    pandoc
    ffmpeg

    texliveFull
    typst

    uv
    nodejs
    rustup
    ghc
    ocamlPackages.utop
    nixfmt

    ispell
    pciutils

    fastfetch
    gdu

    gnupg
  ];

  programs.claude-code = {
    enable = true;
    settings = {
      model = "opus";
      env.EDITOR = "${pkgs.neovim}/bin/nvim";
      statusLine = {
        type = "command";
        command = "bash ~/.claude/statusline-command.sh";
      };
    };
  };

  home.file = {
    ".claude/statusline-command.sh".source = linkHere ".claude/statusline-command.sh";
  };
}
