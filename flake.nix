{
  description = "Flake for Morgan's PC.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    agenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:ryantm/agenix";
    };

    alyraffauf = {
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs-unstable";
      url = "github:alyraffauf/nixcfg";
    };

    disko = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/disko";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.05";
    };

    nixhw = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:alyraffauf/nixhw";
    };

    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:danth/stylix";
    };
  };

  nixConfig = {
    accept-flake-config = true;

    extra-substituters = [
      "https://nix-community.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  outputs = {self, ...}: let
    forDefaultSystems = self.inputs.nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in {
    formatter = forDefaultSystems (system: self.inputs.nixpkgs.legacyPackages.${system}.alejandra);

    homeManagerModules = {
      default = self.inputs.alyraffauf.homeManagerModules.default;
      aly = import ./homes/aly self;
      morgan = import ./homes/morgan self;
    };

    nixosModules.users = import ./userModules self;

    nixosConfigurations."mandarin" = self.inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit self;};
      modules = [
        ./hosts/mandarin
        self.inputs.agenix.nixosModules.default
        self.inputs.alyraffauf.nixosModules.common-auto-upgrade
        self.inputs.alyraffauf.nixosModules.common-base
        self.inputs.alyraffauf.nixosModules.common-locale
        self.inputs.alyraffauf.nixosModules.nixos
        self.inputs.disko.nixosModules.disko
        self.inputs.home-manager.nixosModules.home-manager
        self.inputs.stylix.nixosModules.stylix
        self.nixosModules.users

        {
          home-manager = {
            backupFileExtension = "backup";
            extraSpecialArgs = {inherit self;};
            sharedModules = [self.inputs.alyraffauf.homeManagerModules.default];
            useGlobalPkgs = true;
            useUserPackages = true;
          };
        }
      ];
    };
  };
}
