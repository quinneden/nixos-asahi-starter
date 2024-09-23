{
  description = "Basic NixOS flake template for apple silicon.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    templates = {
      asahi-starter = {
        description = "A starter flake template for configuring NixOS on an apple silicon machine.";
        path = ./asahi-starter;
      };
    };
  };
}
