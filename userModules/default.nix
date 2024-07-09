self: {
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./aly
    ./morgan
    ./options.nix
  ];
}
