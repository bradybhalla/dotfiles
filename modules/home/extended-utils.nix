# extra dev/build tooling plus Claude Code setup

{ pkgs, linkHere, ... }:
{
  home.packages = with pkgs; [
    sqlite

    imagemagick
    pandoc
    ffmpeg

    texliveFull
    typst
    hugo

    cmake
    glibtool
    glfw
    clang-tools

    uv
    nodejs
    rustup
    ghc
    haskell-language-server
    nixfmt

    ansible

    ispell
    pciutils

    fastfetch
    gdu
  ];

  programs.opam.enable = true;

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
