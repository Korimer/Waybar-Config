{ pkgs, config, ... }:
let
  toJSON = barConfig: 
       ( import ./groups.nix barConfig )
    // ( import ./modules.nix barConfig )
    // ( import ./settings.nix barConfig )
  ;

  mkWaybarJson = barName: barConfig: {
    "waybar/${barName}/config.jsonc".text = builtins.toJSON [( toJSON barConfig )];
  };
in
{
  environment.etc = pkgs.mapAttrs' mkWaybarJson config.programs.waybar.bars;
}
