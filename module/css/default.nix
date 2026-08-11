{ gtk-css, lib, config, ... }:
let
  perModule = import ./perModule.nix;

  toCSSAttrs = module: gtk-css.lib.generate (perModule module);
  toCSSText = modules: builtins.concatStringsSep "\n" (map toCSSAttrs modules);
  toCSSComplete = extraCss: allModules: ''
    ${extraCss}
    ${toCSSText allModules}
  '';
  
  mkWaybarCSS = barName: barConfig:
    let
      barLocation = import ../shared/barLocation.nix barName barConfig;
      allModules = import ../shared/uniqueModules.nix barConfig;
    in
    {
      name = barLocation.style;
      value = { text = toCSSComplete barConfig.extraCss allModules.allModules; };
    };
in
  { environment.etc = lib.mapAttrs' mkWaybarCSS config.programs.waybar.bars; }
