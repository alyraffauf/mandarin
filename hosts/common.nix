{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  age.secrets = {
    tailscaleAuthKey.file = ../secrets/tailscale/authKeyFile.age;
  };

  environment = {
    systemPackages = with pkgs; [
      self.inputs.agenix.packages.${pkgs.system}.default
      inxi
    ];

    variables.FLAKE = "github:alyraffauf/mandarin";
  };

  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = config.i18n.defaultLocale;
      LC_IDENTIFICATION = config.i18n.defaultLocale;
      LC_MEASUREMENT = config.i18n.defaultLocale;
      LC_MONETARY = config.i18n.defaultLocale;
      LC_NAME = config.i18n.defaultLocale;
      LC_NUMERIC = config.i18n.defaultLocale;
      LC_PAPER = config.i18n.defaultLocale;
      LC_TELEPHONE = config.i18n.defaultLocale;
      LC_TIME = config.i18n.defaultLocale;
    };
  };

  fileSystems = {
    "/mnt/Archive" = {
      device = "//mauville/Archive";
      fsType = "cifs";
      options = [
        "gid=100"
        "guest"
        "nofail"
        "uid=${toString config.users.users.morgan.uid}"
        "x-systemd.after=network.target"
        "x-systemd.after=tailscaled.service"
        "x-systemd.automount"
        "x-systemd.device-timeout=5s"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=5s"
      ];
    };

    "/mnt/Media" = {
      device = "//mauville/Media";
      fsType = "cifs";
      options = [
        "gid=100"
        "guest"
        "nofail"
        "uid=${toString config.users.users.morgan.uid}"
        "x-systemd.after=network.target"
        "x-systemd.after=tailscaled.service"
        "x-systemd.automount"
        "x-systemd.device-timeout=5s"
        "x-systemd.idle-timeout=60"
        "x-systemd.mount-timeout=5s"
      ];
    };
  };

  home-manager.sharedModules = [
    {
      gtk.gtk3.bookmarks = [
        "file:///mnt/Media"
        "file:///mnt/Archive"
      ];
    }
  ];

  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org/"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = ["aly" "morgan"];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;

    overlays = [
      (final: prev: {
        hyprland = self.inputs.hyprland.packages.${pkgs.system}.hyprland;
        xdg-desktop-portal-hyprland = self.inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
      })
    ];
  };

  services = {
    tailscale = {
      enable = true;
      openFirewall = true;
      authKeyFile = config.age.secrets.tailscaleAuthKey.path;
    };

    xserver.xkb = {
      layout = "us";
      variant = "altgr-intl";
    };
  };

  system.autoUpgrade = {
    allowReboot = true;
    dates = "04:00";
    randomizedDelaySec = "20min";
    enable = true;
    flake = "github:alyraffauf/mandarin";
    operation = "boot";
    rebootWindow = {
      lower = "02:00";
      upper = "05:00";
    };
  };

  time.timeZone = "America/New_York";
}
