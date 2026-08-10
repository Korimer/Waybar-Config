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
    let barLocation = import ../shared/barLocation.nix barName barConfig; in
    {
      name =  "${barLocation}/config.jsonc";
      value = { text = prettyJSON [( toJSON barConfig )]; };
    };
in
{
  environment.etc = lib.mapAttrs' mkWaybarJson config.programs.waybar.bars;
}
