{ lib, config, ... }:
let
  toJSON = barConfig: 
       ( import ./groups.nix barConfig )
    // ( import ./modules.nix barConfig )
    // ( import ./settings.nix barConfig )
  ;

  mkWaybarJson = barName: barConfig: {
    name = "waybar/${barName}/config.jsonc";
    value = { text = builtins.toJSON [( toJSON barConfig )]; };
  };
in
{
  environment.etc = lib.mapAttrs' mkWaybarJson config.programs.waybar.bars;
}
