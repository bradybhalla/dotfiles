# Linux-specific tools that aren't particularly tied to another module

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # apps and tools I use
    alacritty
    emacs-pgtk # pgtk makes it look normal on wayland
    spotify # TODO: only works on x86
    maestral # for cli

    # non-global tray icons
    trayscale
    maestral-gui # tray and daemon

    # utility apps
    nemo # file manager
    qimgv # image viewer
    mpv # video player

    # TODO: hacky solution to make pdf viewer work
    # sioyek's QOpenGLWidget can't create an EGL context on the NVIDIA open
    # driver under native Wayland (journal: "QEGLPlatformContext: Failed to
    # create context: 3009" == EGL_BAD_MATCH): NVIDIA's EGL rejects the GLES2
    (pkgs.symlinkJoin {
      name = "sioyek-xwayland";
      paths = [ pkgs.sioyek ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/sioyek --set QT_QPA_PLATFORM xcb
      '';
    })
  ];
}
