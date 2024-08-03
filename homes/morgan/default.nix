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
      bash.enable = true;
      chromium.enable = true;
      firefox.enable = true;
      vsCodium.enable = true;
    };

    defaultApps.enable = true;

    theme = {
      enable = true;
      wallpaper = "${config.xdg.dataHome}/backgrounds/jr-korpa-9XngoIpxcEo-unsplash.jpg";
    };
  };
}
