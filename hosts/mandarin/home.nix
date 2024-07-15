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
          monitors = [
            "desc:LG Electronics LG ULTRAWIDE 207NTHM9F673,preferred,auto,1.25,vrr,2"
            "desc:LG Electronics LG IPS QHD 207NTVSE5615,preferred,-1152x0,1.25,transform,1"
          ];
        };
      }
    ];
  };
}
