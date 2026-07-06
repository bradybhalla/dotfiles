{ pkgs, linkHere, ... }:
{
  home.packages = with pkgs; [
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
    opam
    ghc
    haskell-language-server
    nixfmt

    ansible

    ispell
    pciutils
  ];

  programs.claude-code = {
    enable = true;
    settings = {
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
