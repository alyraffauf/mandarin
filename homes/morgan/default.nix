self: {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [self.homeManagerModules.default];

  home = {
    username = "morgan";
    homeDirectory = "/home/morgan";
    stateVersion = "24.05";

    packages = with pkgs; [
      fractal
      libreoffice-fresh
      webcord
      xfce.xfce4-taskmanager
    ];
  };

  programs = {
    home-manager.enable = true;

    git = {
      enable = true;
      userName = "Morgan Tamayo";
      userEmail = "mrgntamayo@gmail.com";
    };
  };

  ar.home = {
    apps = {
      chromium.enable = true;
      firefox.enable = true;
      shell.enable = true;
      vsCodium.enable = true;
    };

    defaultApps.enable = true;

    services = {
      gammastep.enable = true;
      randomWallpaper.enable = true;
    };

    theme = {
      enable = true;
      borders.radius = 0;
    };
  };
}
