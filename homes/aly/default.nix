self: {
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [self.homeManagerModules.default];

  home = {
    homeDirectory = "/home/aly";

    packages = with pkgs; [
      browsh
      curl
      git
      wget
    ];

    stateVersion = "24.05";
    username = "aly";
  };

  programs = {
    git = {
      enable = true;
      userName = "Aly Raffauf";
      userEmail = "aly@raffauflabs.com";
    };

    home-manager.enable = true;
  };

  ar.home = {
    apps = {
      chromium.enable = true;
      emacs.enable = true;
      fastfetch.enable = true;
      firefox.enable = true;
      shell.enable = true;
      tmux.enable = true;
      vsCodium.enable = true;
    };

    defaultApps.enable = true;

    services = {
      gammastep.enable = true;
      randomWallpaper.enable = true;
    };

    theme = {
      enable = true;
      borderRadius = 0;
    };
  };
}
