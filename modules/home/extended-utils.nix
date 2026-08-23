# extra dev/build tooling

{ pkgs, linkHere, ... }:
{
  home.packages = with pkgs; [
    gcc
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
    lua-language-server

    ispell
    pciutils

    fastfetch
    gdu

    gnupg

    ansible

    rclone
    kopia
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
