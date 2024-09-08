{
  pkgs,
  self,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/default-dark.yaml";
    image = "${self.inputs.wallpapers}/jr-korpa-9XngoIpxcEo-unsplash.jpg";
    imageScalingMode = "fill";
    polarity = "dark";

    cursor = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };

    fonts = {
      monospace = {
        name = "UbuntuSansMono Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["UbuntuSans"];};
      };

      sansSerif = {
        name = "UbuntuSans Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["UbuntuSans"];};
      };

      serif = {
        name = "Vegur";
        package = pkgs.vegur;
      };

      sizes = {
        applications = 12;
        desktop = 11;
        popups = 12;
        terminal = 13;
      };
    };

    opacity = {
      applications = 1.0;
      desktop = 0.8;
      terminal = 0.8;
      popups = 0.8;
    };
  };
}
