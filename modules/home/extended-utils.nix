{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nerd-fonts.meslo-lg

    imagemagick
    pandoc
    ffmpeg
    ispell

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

    claude-code

    ansible
  ];
}
