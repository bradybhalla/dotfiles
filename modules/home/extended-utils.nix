{ pkgs, ... }:
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

    claude-code

    ansible

    ispell
    pciutils
  ];
}
