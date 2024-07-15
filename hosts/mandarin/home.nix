{
  config,
  lib,
  pkgs,
  ...
}: {
  home-manager = {
    sharedModules = [
      {
        ar.home.desktop.hyprland = {
          autoSuspend = false;
          monitors = ["desc:LG Electronics LG ULTRAWIDE 207NTHM9F673,preferred,auto,1.25,vrr,2"];
        };
      }
    ];
  };
}
