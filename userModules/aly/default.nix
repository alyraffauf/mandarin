{
  config,
  lib,
  pkgs,
  self,
  ...
}: {
  config = lib.mkIf config.ar.users.aly.enable {
    home-manager.users.aly = self.homeManagerModules.aly;

    users.users.aly = {
      description = "Aly Raffauf";
      extraGroups = config.ar.users.defaultGroups;
      hashedPassword = config.ar.users.aly.password;
      isNormalUser = true;
      linger = true;
      uid = 1000;
    };
  };
}
