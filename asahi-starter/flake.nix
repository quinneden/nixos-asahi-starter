{
  description = "NixOS config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    lix-module,
    nixos-apple-silicon,
    ...
  } @ inputs: let
    system = "aarch64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [nixos-apple-silicon.overlays.default];
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = {
          inherit self inputs;
          username = "FIXME"; # Replace with actual user.
        };
        modules = [
          ./nixos/configuration.nix
          lix-module.nixosModules.default
          nixos-apple-silicon.nixosModules.default
        ];
      };
    };
  };
}
