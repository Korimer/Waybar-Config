{ gtk-css, lib, config, ... }:
let
  perModule = import ./perModule.nix;

  toCSS = module: gtk-css.lib.generate (perModule module);
  
  mkWaybarCSS = barName: barConfig:
    let
      barLocation = import ../shared/barLocation.nix barName barConfig;
      allModules = import ../shared/uniqueModules.nix barConfig;
    in
    {
      name = "${barLocation}/style.css";
      value = { text = builtins.concatStringsSep "\n" (map toCSS allModules.allModules); };
    };
in
  { environment.etc = lib.mapAttrs' mkWaybarCSS config.programs.waybar.bars; }
