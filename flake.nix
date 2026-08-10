{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    gtk-css.url = "github:Korimer/nix-gtk-css";
  };

  outputs = { self, nixpkgs, gtk-css}: {
    nixosModules.default = import ./module;
  };
}
