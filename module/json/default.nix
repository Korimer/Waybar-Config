{ lib, pkgs, config, ... }:
let
  toJSON = barConfig:
    ( import ./modules.nix barConfig )
    // ( import ./settings.nix barConfig )
  ;

  prettyJSON = attrs:
    builtins.readFile (
      pkgs.runCommand "pretty-json" {
        json = builtins.toJSON attrs;
      } ''
        printf '%s' "$json" | ${pkgs.jq}/bin/jq . > $out
      ''
    );

  mkWaybarJson = barName: barConfig:
    let
      barLocation = import ../shared/barLocation.nix barName barConfig;
      allModules = import ../shared/uniqueModules.nix barConfig;
    in
    {
      name =  "${barLocation}/config.jsonc";
      value = { text = prettyJSON [( toJSON allModules )]; };
    };
in
  { environment.etc = lib.mapAttrs' mkWaybarJson config.programs.waybar.bars; }
