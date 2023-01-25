{ config, pkgs, lib, ... }:
let
  nixgl = import <nixgl> {} ;
  nixGLWrap = pkg: pkgs.runCommand "${pkg.name}-nixgl-wrapper" {} ''
    mkdir $out
    ln -s ${pkg}/* $out
    rm $out/bin
    mkdir $out/bin
    for bin in ${pkg}/bin/*; do
     wrapped_bin=$out/bin/$(basename $bin)
     echo "exec ${lib.getExe nixgl.auto.nixGLDefault} $bin \$@" > $wrapped_bin
     chmod +x $wrapped_bin
    done
  '';
in {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "adalessa";
  home.homeDirectory = "/home/adalessa";

  home.packages = [
    pkgs.lazygit
    pkgs.gpick
    pkgs.insomnia
    pkgs.lsd
    pkgs.php82
    pkgs.php82Packages.composer
    pkgs.php82Packages.phpstan
    pkgs.php82Packages.phpcs
    pkgs.go
    pkgs.rustup
    pkgs.nodejs
    pkgs.nodePackages.npm
    pkgs.bat
    pkgs.jq
    pkgs.ripgrep
    pkgs.tmux
    pkgs.screenkey
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.wezterm = {
    enable = true;
    package = nixGLWrap pkgs.wezterm;
  };
}
