# apps for linux that aren't particularly tied to another module

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
    emacs-pgtk # pgtk makes it look normal on wayland
    spotify
    qimgv # image viewer
    mpv # video player

    # TODO: hacky solution to make it work
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
