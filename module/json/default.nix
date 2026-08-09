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

  mkWaybarJson = barName: barConfig: {
    name = "waybar/${barName}/config.jsonc";
    value = { text = prettyJSON [( toJSON barConfig )]; };
  };
in
{
  environment.etc = lib.mapAttrs' mkWaybarJson config.programs.waybar.bars;
}
