{
  description = "Basic NixOS flake template for apple silicon.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    templates = {
      default = {
        description = "A starter flake template for configuring NixOS on an apple silicon machine.";
        path = ./asahi-starter;
      };
    };
  };
}
